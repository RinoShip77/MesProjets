import { useEffect, useState, useRef } from 'react'
import { Link } from 'react-router-dom'
import { api } from '../services/api.jsx'
import HeroCarousel from "./HeroCarousel.jsx"

function GenreRow({ genre, items }) {
  const rowRef = useRef(null)
  const [atStart, setAtStart] = useState(true)
  const [atEnd, setAtEnd] = useState(false)

  const checkScroll = () => {
    const el = rowRef.current
    if (!el) return
    setAtStart(el.scrollLeft === 0)
    setAtEnd(el.scrollLeft + el.clientWidth >= el.scrollWidth - 1)
  }

  const scroll = (dir) => {
    if (rowRef.current) {
      rowRef.current.scrollBy({ left: dir * 300, behavior: 'smooth' })
    }
  }

  useEffect(() => {
    const el = rowRef.current
    if (!el) return
    el.addEventListener('scroll', checkScroll)
    checkScroll()
    return () => el.removeEventListener('scroll', checkScroll)
  }, [])

  return (
    <div className="mb-5 position-relative genre-row-wrapper">
      <h4 className="mb-3">{genre}</h4>

      <div
        ref={rowRef}
        className="scroll-row d-flex gap-3 pb-2"
        style={{ overflowX: 'auto', scrollSnapType: 'x mandatory' }}
      >
        {items.map(v => (
          <Link key={v.id} to={`/watch/${v.id}`} className="text-decoration-none text-dark">
            <div className="video-card" style={{ width: '240px', scrollSnapAlign: 'start' }}>
              <div className="ratio ratio-16x9">
                <img
                  src={v.thumbnail_url}
                  alt={v.title}
                  className="img-fluid rounded"
                  style={{ objectFit: 'cover' }}
                />
              </div>
              <p className="mt-2 fw-semibold">{v.title}</p>
            </div>
          </Link>
        ))}
      </div>

      {!atStart && (
        <button className="carousel-btn left" onClick={() => scroll(-1)}>&#10216;</button>
      )}
      {!atEnd && (
        <button className="carousel-btn right" onClick={() => scroll(1)}>&#10217;</button>
      )}

      <div className="fade-left" />
      <div className="fade-right" />
    </div>
  )
}

export default function BrowseByGenre() {
  const [videos, setVideos] = useState({})
  const [groupedVideos, setGroupedVideos] = useState({})
  const [loading, setLoading] = useState(true)
  const user = JSON.parse(localStorage.getItem('streamlyUser'))

  useEffect(() => {
    api.get('/videos').then(res => {
      const grouped = {}
      res.videos.forEach(v => {
        const genre = v.genre || 'Uncategorized'
        if (!grouped[genre]) grouped[genre] = []
        grouped[genre].push(v)
      })
      setVideos(res.videos)
      setGroupedVideos(grouped)
    }).finally(() => setLoading(false))
  }, [])

  if (loading) return <div className="container py-5">Loading…</div>

  return (
    <div className="container py-4">
      <h1 className="mb-5 text-center">Connected as {user.name}</h1>
      <HeroCarousel videos={videos} count={5} />
      {Object.entries(groupedVideos).map(([genre, items]) => (
        <GenreRow key={genre} genre={genre} items={items} />
      ))}
    </div>
  )
}