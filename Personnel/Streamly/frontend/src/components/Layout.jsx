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
              <li className="nav-item dropdown">
                <a className="nav-link dropdown-toggle" data-bs-toggle="dropdown">Browse</a>
                <ul className="dropdown-menu">
                  <li>
                    <NavLink className="dropdown-item" to="/browse">All Movies</NavLink>
                  </li>
                  <li><hr className="dropdown-divider" /></li>
                  <li>
                    <NavLink className="dropdown-item" to="/browse/genres">By Genres</NavLink>
                  </li>
                </ul>
              </li>
              <li className="nav-item">
                <NavLink className="nav-link" to="/admin">Admin</NavLink>
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