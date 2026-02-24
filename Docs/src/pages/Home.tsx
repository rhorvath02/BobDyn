export default function Home() {
  return (
    <div className="page">
      <h1>BobDyn</h1>

      <p>
        BobDyn is a reference framework for defining, interpreting, and
        evaluating vehicle behavior using first-principles vehicle dynamics.
        The emphasis is on physically meaningful descriptions of vehicle response,
        independent of any specific test procedure, competition rule set, or
        prescriptive design target.
      </p>

      <p>
        This site documents a canonical set of vehicle performance metrics used
        to describe handling, stability, and dynamic response. These metrics are
        intended to form a common technical language that bridges simulation,
        physical testing, and vehicle design workflows.
      </p>

      <h2>Design Philosophy</h2>

      <p>
        Rather than prescribing what a vehicle <em>should</em> be optimized for,
        BobDyn defines what a vehicle <em>does</em> physically. Each metric
        is grounded in vehicle dynamics theory and describes an observable
        aspect of system behavior.
      </p>

      <p>
        The relative importance of any metric is intentionally left unspecified.
        Weighting and prioritization depend on the intended application,
        operating environment, and design objectives of a given team or program.
      </p>

      <p>
        By separating physical behavior from prioritization, the same framework
        can be applied to motorsport, production vehicles, research programs, or
        education without modification.
      </p>

      <h2>What This Site Contains</h2>

      <ul>
        <li>
          Conceptual definitions of vehicle performance metrics and the physical
          behaviors they represent
        </li>
        <li>
          Explanations of why these metrics are commonly used to evaluate vehicle
          handling, stability, and dynamic response
        </li>
        <li>
          A consistent vocabulary for discussing steady-state, transient, and
          frequency-domain vehicle behavior
        </li>
      </ul>

      <h2>What This Site Does Not Do</h2>

      <ul>
        <li>Prescribe numerical targets or design requirements</li>
        <li>Rank metrics by importance or assign weights</li>
        <li>Recommend specific test standards or procedures</li>
        <li>Provide tuning rules, control strategies, or optimization guidance</li>
      </ul>

      <p className="closing-note">
        The intent of BobDyn is to provide a clear, physics-based foundation
        upon which application-specific decisions can be made using objective,
        reproducible metrics.
      </p>
    </div>
  );
}
