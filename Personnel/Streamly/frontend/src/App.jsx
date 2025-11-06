import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout.jsx'
import Home from './pages/Home.jsx'
import Browse from './components/BrowseAll.jsx'
import BrowseByGenre from "./components/BrowseByGenre.jsx"
import Watch from './pages/Watch.jsx'
import NotFound from './pages/NotFound.jsx'
import Admin from "./pages/Admin.jsx"

export default function App() {
  return (
    <Routes>
      <Route element={<Layout />}>
        <Route path="/" element={<Home />} />
        <Route path="/browse" element={<Browse />} />
        <Route path="/browse/genres" element={<BrowseByGenre />} />
        <Route path="/watch/:videoId" element={<Watch />} />
        <Route path="/admin" element={<Admin />} />
      </Route>
      <Route path="*" element={<NotFound />} />
    </Routes>
  )
}