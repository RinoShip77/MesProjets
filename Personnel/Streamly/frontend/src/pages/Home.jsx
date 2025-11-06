import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { api } from '../services/api.jsx'

export default function Home() {
  const [users, setUsers] = useState([])
  const navigate = useNavigate()

  useEffect(() => {
    api.get('/users').then(setUsers)
  }, [])

  const handleSelect = (user) => {
    localStorage.setItem('streamlyUser', JSON.stringify(user))
    navigate('/browse/genres')
  }

  return (
    <div className="container py-5 text-center">
      <h1 className="mb-4">Who's watching?</h1>
      <div className="d-flex justify-content-center flex-wrap gap-4">
        {users.map(user => (
          <div key={user.id} style={{ cursor: 'pointer' }} onClick={() => handleSelect(user)}>
            <img
              src={user.avatar_url}
              alt={user.name}
              className="rounded-circle border border-light"
              style={{ width: '120px', height: '120px', objectFit: 'cover' }}
            />
            <p className="mt-2 fw-bold">{user.name}</p>
          </div>
        ))}
      </div>
    </div>
  )
}