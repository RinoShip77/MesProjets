const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
require('dotenv').config()
const { pool } = require('./database')

const app = express()
app.use(cors({ origin: ['http://localhost:5173'], credentials: true }))
app.use(express.json())
app.use(morgan('dev'))

app.get('/api/health', (req, res) => res.json({ status: 'ok' }))

// List all videos
app.get('/api/videos', async (req, res) => {
  const { search, genres, sort, page = 1, limit = 10 } = req.query
  const offset = (page - 1) * limit
  const genresList = await pool.query("SHOW COLUMNS FROM videos LIKE 'genre'")

  let sql = 'SELECT SQL_CALC_FOUND_ROWS * FROM videos WHERE 1=1'
  const params = []

  // Search filter
  if (search) {
    sql += ' AND (LOWER(title) LIKE ? OR LOWER(description) LIKE ?)'
    params.push(`%${search.toLowerCase()}%`, `%${search.toLowerCase()}%`)
  }

  // Genre filter (comma-separated list)
  if (genres) {
    const genreList = genres.split(',')
    sql += ` AND genre IN (${genreList.map(() => '?').join(',')})`
    params.push(...genreList)
  }

  // Sorting
  switch (sort) {
    case 'title-asc':
      sql += ' ORDER BY title ASC'
      break
    case 'title-desc':
      sql += ' ORDER BY title DESC'
      break
    case 'date-asc':
      sql += ' ORDER BY created_at ASC'
      break
    case 'date-desc':
      sql += ' ORDER BY created_at DESC'
      break
    default:
      sql += ' ORDER BY created_at DESC'
  }

  sql += ' LIMIT ? OFFSET ?'
  params.push(Number(limit), Number(offset))

  const [rows] = await pool.query(sql, params)
  const [[{ 'FOUND_ROWS()': total }]] = await pool.query('SELECT FOUND_ROWS()')

  res.json({ videos: rows, genres: genresList[0][0].Type, total })
})

// Get single video incl. stream URL
app.get('/api/videos/:id', async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM videos WHERE id = ?', [req.params.id])
  if (!rows.length) return res.status(404).json({ error: 'Not found' })
  res.json(rows[0])
})

// Create a video endpoint for testing
app.post('/api/admin/videos', async (req, res) => {
  const { title, description, genre, thumbnail_url, backdrop_url, created_at } = req.body
  await pool.query(
    `INSERT INTO videos (title, description, genre, thumbnail_url, backdrop_url, created_at)
     VALUES (?, ?, ?, ?, ?, ?)`,
    [title, description, genre, thumbnail_url, backdrop_url, created_at || new Date()]
  )
  res.status(201).json({ success: true })
})
// app.post('/api/videos', async (req, res) => {
//   const { title, description, genre, thumbnail_url, stream_url } = req.body
//   if (!title || !stream_url) return res.status(400).json({ error: 'title and stream_url required' })
//   const [result] = await pool.query(
//     'INSERT INTO videos (title, description, genre, thumbnail_url, stream_url) VALUES (?, ?, ?, ?, ?)',
//     [title, description || '', genre || 'Action', thumbnail_url || '', stream_url]
//   )
//   res.status(201).json({ id: result.insertId })
// })

// Update an existing movie
app.put('/api/admin/videos/:id', async (req, res) => {
  const { title, description, genre, thumbnail_url, backdrop_url } = req.body
  await pool.query(
    `UPDATE videos SET title = ?, description = ?, genre = ?, thumbnail_url = ?, backdrop_url = ?
     WHERE id = ?`,
    [title, description, genre, thumbnail_url, backdrop_url, req.params.id]
  )
  res.status(200).json({ success: true })
})

// Delete a movie
app.delete('/api/admin/videos/:id', async (req, res) => {
  await pool.query('DELETE FROM videos WHERE id = ?', [req.params.id])
  res.status(200).json({ success: true })
})

// List all users
app.get('/api/users', async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM users ORDER BY name')
  res.json(rows)
})

// Createw a user endpoint for testing
app.post('/api/admin/users', async (req, res) => {
  const { name, avatar_url } = req.body
  await pool.query('INSERT INTO users (name, avatar_url) VALUES (?, ?)', [name, avatar_url])
  res.status(201).json({ success: true })
})

// Update an existing user
app.put('/api/admin/users/:id', async (req, res) => {
  const { name, avatar_url } = req.body
  await pool.query('UPDATE users SET name = ?, avatar_url = ? WHERE id = ?', [name, avatar_url, req.params.id])
  res.status(200).json({ success: true })
})

// Delete a user
app.delete('/api/admin/users/:id', async (req, res) => {
  await pool.query('DELETE FROM users WHERE id = ?', [req.params.id])
  res.status(200).json({ success: true })
})

const port = process.env.PORT || 4000
app.listen(port, () => console.log(`API running on http://localhost:${port}`))