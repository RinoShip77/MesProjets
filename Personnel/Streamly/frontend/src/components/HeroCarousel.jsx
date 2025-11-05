import { Link } from 'react-router-dom'
import { useMemo } from 'react'

export default function HeroCarousel({ videos, count = 5 }) {
  // Randomize and pick a subset
  const featured = useMemo(() => {
    if (!videos || videos.length === 0) return []
    const shuffled = [...videos].sort(() => 0.5 - Math.random())
    return shuffled.slice(0, count)
  }, [videos, count])

  if (featured.length === 0) return null

  return (
    <div id="heroCarousel" className="carousel slide" data-bs-ride="carousel" data-bs-interval="5000">
      {/* Indicators */}
      <div className="carousel-indicators">
        {featured.map((_, idx) => (
          <button
            key={idx}
            type="button"
            data-bs-target="#heroCarousel"
            data-bs-slide-to={idx}
            className={idx === 0 ? 'active' : ''}
            aria-current={idx === 0 ? 'true' : undefined}
            aria-label={`Slide ${idx + 1}`}
          ></button>
        ))}
      </div>

      {/* Slides */}
      <div className="carousel-inner">
        {featured.map((video, idx) => (
          <div
            key={video.id}
            className={`carousel-item ${idx === 0 ? 'active' : ''}`}
          >
            <div
              className="d-flex align-items-center text-white"
              style={{
                backgroundImage: `url(${video.thumbnail_url})`,
                backgroundSize: 'contain',
                backgroundRepeat: 'no-repeat',
                backgroundPosition: 'center',
                minHeight: '60vh',
                position: 'relative'
              }}
            >
              <div className="overlay position-absolute top-0 start-0 w-100 h-100"
                style={{ background: 'rgba(0,0,0,0.5)' }}></div>
              <div className="container position-relative z-1 text-center">
                <h1 className="display-4 fw-bold">{video.title}</h1>
                <p className="lead">{video.description}</p>
                <Link to={`/watch/${video.id}`} className="btn btn-lg btn-primary me-2">
                  ▶ Play
                </Link>
                <Link to={`/watch/${video.id}`} className="btn btn-lg btn-outline-light">
                  More Info
                </Link>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Controls */}
      <button className="carousel-control-prev " type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
        <span className="carousel-control-prev-icon mt-auto mb-3" aria-hidden="true"></span>
        <span className="visually-hidden">Previous</span>
      </button>
      <button className="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
        <span className="carousel-control-next-icon mt-auto mb-3" aria-hidden="true"></span>
        <span className="visually-hidden">Next</span>
      </button>
    </div>
  )
}