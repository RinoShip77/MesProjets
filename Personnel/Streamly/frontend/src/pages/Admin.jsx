import { useEffect, useState } from 'react'
import { api } from '../services/api.jsx'
import ManageProfiles from "../components/ManageProfiles.jsx"

export default function Admin() {
  const [videos, setVideos] = useState([])
  const [form, setForm] = useState({
    title: '',
    description: '',
    genre: '',
    thumbnail_url: '',
    backdrop_url: ''
  })
  const [editingId, setEditingId] = useState(null)

  useEffect(() => {
    api.get('/videos').then(res => setVideos(res.videos))
  }, [])

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (editingId) {
      await api.put(`/admin/videos/${editingId}`, form)
    } else {
      await api.post('/admin/videos', form)
    }
    setForm({ title: '', description: '', genre: '', thumbnail_url: '', backdrop_url: '' })
    setEditingId(null)
    const res = await api.get('/videos')
    setVideos(res.videos)
  }

  const handleEdit = (video) => {
    setForm(video)
    setEditingId(video.id)
  }

  return (
    <div className="container py-4">
      <h2>{editingId ? 'Edit Movie' : 'Add New Movie'}</h2>
      <form onSubmit={handleSubmit} className="mb-4">
        <input className="form-control mb-2" placeholder="Title" value={form.title} onChange={e => setForm({ ...form, title: e.target.value })} />
        <textarea className="form-control mb-2" placeholder="Description" value={form.description} onChange={e => setForm({ ...form, description: e.target.value })} />
        <input className="form-control mb-2" placeholder="Genre" value={form.genre} onChange={e => setForm({ ...form, genre: e.target.value })} />
        <input className="form-control mb-2" placeholder="Thumbnail URL" value={form.thumbnail_url} onChange={e => setForm({ ...form, thumbnail_url: e.target.value })} />
        <input className="form-control mb-2" placeholder="Backdrop URL" value={form.backdrop_url} onChange={e => setForm({ ...form, backdrop_url: e.target.value })} />
        <button className="btn btn-primary">{editingId ? 'Update' : 'Add'}</button>
      </form>

      <h3>Existing Movies</h3>
      <ul className="list-group">
        {videos.map(v => (
          <li key={v.id} className="list-group-item d-flex justify-content-between align-items-center">
            <span>{v.title} <small className="text-muted">({v.genre})</small></span>
            <button className="btn btn-sm btn-outline-secondary" onClick={() => handleEdit(v)}>Edit</button>
          </li>
        ))}
      </ul>

      <ManageProfiles />
    </div>
  )
}