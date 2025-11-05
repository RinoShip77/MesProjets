import { useEffect, useRef, useState } from 'react'
import { useParams } from 'react-router-dom'
import Plyr from 'plyr'
import Hls from 'hls.js'
import { api } from '../services/api.jsx'
import 'plyr/dist/plyr.css'

export default function Watch() {
  const { videoId } = useParams()
  const videoRef = useRef(null)
  const [video, setVideo] = useState(null)

  useEffect(() => {
    api.get(`/videos/${videoId}`).then(setVideo)
  }, [videoId])

  useEffect(() => {
    if (!video || !videoRef.current) return
    const player = new Plyr(videoRef.current, { controls: ['play', 'progress', 'current-time', 'mute', 'volume', 'fullscreen'] })
    const source = video.stream_url

    if (Hls.isSupported() && source.endsWith('.m3u8')) {
      const hls = new Hls()
      hls.loadSource(source)
      hls.attachMedia(videoRef.current)
    } else {
      // Fallback: native HLS support (Safari) or MP4
      videoRef.current.src = source
    }

    return () => player.destroy()
  }, [video])

  if (!video) return <div>Loading…</div>

  return (
    <div>
      <h2>{video.title}</h2>
      <video ref={videoRef} className="plyr__video-embed" data-poster={video.thumbnail_url} controls playsInline />
      <p className="mt-3">{video.description}</p>
    </div>
  )
}