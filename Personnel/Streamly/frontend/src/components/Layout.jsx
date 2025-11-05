import { Outlet, Link, NavLink } from 'react-router-dom'

export default function Layout() {
  return (
    <>
      <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
        <div className="container-fluid">
          <Link className="navbar-brand" to="/">Streamly</Link>
          <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
            <span className="navbar-toggler-icon"></span>
          </button>
          <div id="nav" className="collapse navbar-collapse">
            <ul className="navbar-nav ms-auto">
              <li className="nav-item">
                <NavLink className="nav-link" to="/browse">Browse</NavLink>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <main className="container-fluid py-4">
        <Outlet />
      </main>
      <footer className="bg-dark text-light py-3 mt-auto">
        <div className="container small">&copy; {new Date().getFullYear()} Streamly</div>
      </footer>
    </>
  )
}