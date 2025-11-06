import { useEffect, useState } from 'react'
import { api } from '../services/api.jsx'

export default function ManageProfiles() {
  const [users, setUsers] = useState([])
  const [form, setForm] = useState({ name: '', avatar_url: '' })
  const [editingId, setEditingId] = useState(null)

  useEffect(() => {
    api.get('/users').then(setUsers)
  }, [])

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (editingId) {
      await api.put(`/users/${editingId}`, form)
    } else {
      await api.post('/users', form)
    }
    setForm({ name: '', avatar_url: '' })
    setEditingId(null)
    const res = await api.get('/users')
    setUsers(res)
  }

  const handleEdit = (user) => {
    setForm(user)
    setEditingId(user.id)
  }

  const handleDelete = async (id) => {
    await api.delete(`/users/${id}`)
    const res = await api.get('/users')
    setUsers(res)
  }

  return (
    <div className="container py-4">
      <h2>{editingId ? 'Edit Profile' : 'Add New Profile'}</h2>
      <form onSubmit={handleSubmit} className="mb-4">
        <input className="form-control mb-2" placeholder="Name" value={form.name} onChange={e => setForm({ ...form, name: e.target.value })} />
        <input className="form-control mb-2" placeholder="Avatar URL" value={form.avatar_url} onChange={e => setForm({ ...form, avatar_url: e.target.value })} />
        <button className="btn btn-primary">{editingId ? 'Update' : 'Add'}</button>
      </form>

      <h3>Profiles</h3>
      <ul className="list-group">
        {users.map(user => (
          <li key={user.id} className="list-group-item d-flex justify-content-between align-items-center">
            <span>
              <img src={user.avatar_url} alt={user.name} className="rounded-circle me-2" style={{ width: '40px', height: '40px' }} />
              {user.name}
            </span>
            <div>
              <button className="btn btn-sm btn-outline-secondary me-2" onClick={() => handleEdit(user)}>Edit</button>
              <button className="btn btn-sm btn-outline-danger" onClick={() => handleDelete(user.id)}>Delete</button>
            </div>
          </li>
        ))}
      </ul>
    </div>
  )
}