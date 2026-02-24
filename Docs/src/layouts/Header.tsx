import { Link, Outlet } from "react-router-dom";
import bobIcon from "/bob.png";

export default function MainLayout() {
  return (
    <>
      <header className="topbar">
        <Link to="/" className="brand">
          <img src={bobIcon} alt="BobDyn logo" />
          <span>BobDyn</span>
        </Link>

        <nav>
          <Link to="/metrics">Metrics</Link>
        </nav>
      </header>

      <main>
        <Outlet />
      </main>
    </>
  );
}
