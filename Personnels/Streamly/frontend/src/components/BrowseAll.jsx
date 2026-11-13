import { useEffect, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import { api } from '../services/api.jsx'
import HeroCarousel from './HeroCarousel.jsx'

export default function Browse() {
  const limit = 12
  const [videos, setVideos] = useState([])
  const [page, setPage] = useState(1)
  const [total, setTotal] = useState(0)
  const [loading, setLoading] = useState(true)
  const totalPages = Math.ceil(total / limit)
  const user = JSON.parse(localStorage.getItem('streamlyUser'))

  // URL query params
  const [searchParams, setSearchParams] = useSearchParams()

  // State synced with URL
  const [search, setSearch] = useState(searchParams.get('search') || '')
  const [selectedGenres, setSelectedGenres] = useState(
    searchParams.get('genres') ? searchParams.get('genres').split(',') : []
  )
  const [genres, setGenres] = useState([])
  const [sortMode, setSortMode] = useState(searchParams.get('sort') || 'date-desc')
  // options: 'title-asc', 'title-desc', 'date-asc', 'date-desc'

  // Fetch videos whenever filters change
  useEffect(() => {
    const params = new URLSearchParams()
    if (search) params.set('search', search)
    if (selectedGenres.length > 0) params.set('genres', selectedGenres.join(','))
    if (sortMode) params.set('sort', sortMode)

    // Update URL
    params.set('page', page)
    params.set('limit', limit)
    setSearchParams(params)

    // Fetch videosfrom backend
    api.get(`/videos?${params.toString()}`)
      .then(res => {
        // Set the genres list
        const uniqueGenres = res.genres.substring(res.genres.indexOf('(') + 1, res.genres.lastIndexOf(')')).replace(/'/g, "").split(',').map(item => item.trim());
        setGenres(uniqueGenres)

        // Set videos and total count
        setVideos(res.videos)
        setTotal(res.total)
      })
      .finally(() => setLoading(false))

  }, [search, selectedGenres, sortMode, setSearchParams, page])


  // Filtered list
  const filtered = videos.filter(v => {
    const matchesSearch =
      v.title.toLowerCase().includes(search.toLowerCase()) ||
      v.description.toLowerCase().includes(search.toLowerCase())

    const matchesGenre =
      selectedGenres.length === 0 || selectedGenres.includes(v.genre)

    return matchesSearch && matchesGenre
  })

  // Apply sorting
  const sorted = [...filtered].sort((a, b) => {
    switch (sortMode) {
      case 'title-asc': return a.title.localeCompare(b.title)
      case 'title-desc': return b.title.localeCompare(a.title)
      case 'date-asc': return new Date(a.created_at) - new Date(b.created_at)
      case 'date-desc': return new Date(b.created_at) - new Date(a.created_at)
      default: return 0
    }
  })

  const toggleGenre = (genre) => {
    setSelectedGenres(prev => prev.includes(genre) ? prev.filter(g => g !== genre) : [...prev, genre]
    )
  }

  if (loading) return <div>Loading…</div>

  return (
    <div className="d-flex flex-column h-100">
      <h1 className="mb-5 text-center">Connected as {user.name}</h1>
      <HeroCarousel videos={videos} count={5} />

      {/* Catalog */}
      <div className="container-fluid flex-grow-1">
        {/* Search bar */}
        <div className="container-fluid py-3">
          <input
            type="text"
            className="form-control form-control-lg"
            placeholder="Search movies..."
            value={search}
            onChange={e => setSearch(e.target.value)}
          />
        </div>

        {/* Filter + Sort Controls */}
        <div className="container-fluid d-flex justify-content-between align-items-center mb-3">
          <button className="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#filterModal">
            Filters
          </button>

          <div className="btn-group">
            <button className="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown">
              Sort
            </button>
            <ul className="dropdown-menu">
              <li><button className="dropdown-item" onClick={() => setSortMode('title-asc')}>Title A–Z</button></li>
              <li><button className="dropdown-item" onClick={() => setSortMode('title-desc')}>Title Z–A</button></li>
              <li><button className="dropdown-item" onClick={() => setSortMode('date-asc')}>Oldest First</button></li>
              <li><button className="dropdown-item" onClick={() => setSortMode('date-desc')}>Newest First</button></li>
            </ul>
          </div>
        </div>

        {/* Active Filters */}
        <div className="container-fluid mb-3">
          <div className="d-flex flex-wrap gap-2">
            {search && (
              <span className="badge bg-info text-dark d-flex align-items-center">
                Search: "{search}"
                <button
                  type="button"
                  className="btn-close btn-close-white ms-2"
                  aria-label="Clear"
                  onClick={() => setSearch('')}
                  style={{ fontSize: '0.6rem' }}
                ></button>
              </span>
            )}

            {selectedGenres.map(genre => (
              <span key={genre} className="badge bg-primary d-flex align-items-center">
                {genre}
                <button
                  type="button"
                  className="btn-close btn-close-white ms-2"
                  aria-label="Remove"
                  onClick={() => toggleGenre(genre)}
                  style={{ fontSize: '0.6rem' }}
                ></button>
              </span>
            ))}

            {(search || selectedGenres.length > 0) && (
              <button
                className="btn btn-sm btn-outline-danger"
                onClick={() => {
                  setSearch('')
                  setSelectedGenres([])
                }}
              >
                Clear All
              </button>
            )}
          </div>
        </div>

        {/* Modal */}
        <div className="modal fade" id="filterModal" tabIndex="-1" aria-hidden="true">
          <div className="modal-dialog modal-dialog-centered">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title">Filters</h5>
                <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div className="modal-body">
                <h6>Genres</h6>
                <div className="d-flex flex-wrap gap-2">
                  {genres.map(genre => (
                    <button
                      key={genre}
                      className={`badge rounded-pill ${selectedGenres.includes(genre) ? 'bg-primary' : 'bg-secondary'}`}
                      style={{ cursor: 'pointer', fontSize: '1rem', padding: '0.6em 1em' }}
                      onClick={() => toggleGenre(genre)}
                    >
                      {genre}
                    </button>
                  ))}
                </div>
              </div>
              <div className="modal-footer">
                <button className="btn btn-outline-danger" onClick={() => setSelectedGenres([])}>
                  Clear Filters
                </button>
                <button className="btn btn-primary" data-bs-dismiss="modal">Apply</button>
              </div>
            </div>
          </div>
        </div>

        {/* Video grid */}
        <div className="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4 flex-grow-1">
          {sorted.map(v => (
            <div key={v.id} className="col d-flex">
              <div className="card flex-fill">
                <img src={v.thumbnail_url} alt={v.title} className="card-img-top img-fluid rounded-bottom-0 thumbnail" loading="lazy" />
                <div className="card-body">
                  <h5 className="card-title">{v.title}</h5>
                  <p className="card-text small text-muted">{v.genre}</p>
                  <Link to={`/watch/${v.id}`} className="btn btn-primary w-100">Watch</Link>
                </div>
              </div>
            </div>
          ))}
          {sorted.length === 0 && (
            <div className="col">
              <p className="text-muted">No results found.</p>
            </div>
          )}
        </div>

        {/* Pagination */}
        <nav className="d-flex justify-content-center mt-3" aria-label="Page navigation">
          <ul className="pagination">
            <li key={page - 1} className="page-item">
              <a className="page-link" type="button" onClick={() => setPage(page - 1)} aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
              </a>
            </li>
            {[...Array(totalPages)].map((_, i) => (
              <li key={i} className={`page-item ${page === i + 1 ? 'active' : ''}`}>
                <a className="page-link" type="button" onClick={() => setPage(i + 1)}>
                  {i + 1}
                </a>
              </li>
            ))}
            <li key={page + 1} className="page-item">
              <a className="page-link" type="button" onClick={() => setPage(page + 1)} aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
              </a>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  )
}