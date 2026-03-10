import { NavLink, Outlet } from "react-router-dom";
import "./layout.css";
import bobIcon from "/bob.png";

export default function AppLayout() {
  return (
    <>
      <header className="nav">
        <div className="nav-inner">
          <div className="left brand">
            <img src={bobIcon} alt="BobLib logo" />
            <div className="nav-title">BobLib</div>
          </div>

          <nav className="nav-links">
            <NavLink to="/" end>Home</NavLink>
            <NavLink to="/metrics">Metrics</NavLink>
          </nav>
        </div>
      </header>

      <main className="content">
        <Outlet />
      </main>
    </>
  );
}
