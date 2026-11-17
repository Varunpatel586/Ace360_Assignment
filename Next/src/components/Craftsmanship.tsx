import styles from "./Craftsmanship.module.css";

const PILLARS = [
  {
    title: "Kiln-Dried Hardwood",
    body: "0% moisture seasoned Teak and Sal wood with reinforced mortise-and-tenon corner joints. Termite-proofed for lasting structural peace of mind.",
    tag: "Grade A Solid Timber",
  },
  {
    title: "38-Density Cold Foam",
    body: "Multi-layer cold-cure memory foam cores supported by S-spring suspension bands. Maintains rebound resilience and anatomical contour for 15+ years.",
    tag: null,
  },
  {
    title: "Direct from Factory",
    body: "Direct atelier-to-residence model skips middlemen markups. You invest purely in authentic timber, foam grade, and generational craft.",
    tag: "Zero Distributor Margin",
  },
];

const METRICS = [
  { value: "26", label: "Years of Precision Craft" },
  { value: "42k+", label: "Homes Furnished Across India" },
  { value: "10-Yr", label: "Frame Warranty Guarantee" },
];

export default function Craftsmanship() {
  return (
    <section className={styles.section} id="craftsmanship">
      <div className={styles.inner}>
        <h2 className={styles.heading}>Built by the Manufacturer</h2>
        <p className={styles.subheading}>
          From our workshop floor to your living room — no distributors, no
          compromises.
        </p>

        <div className={styles.pillars}>
          {PILLARS.map((pillar) => (
            <article key={pillar.title} className={styles.pillar}>
              <h3 className={styles.pillarTitle}>{pillar.title}</h3>
              <p className={styles.pillarBody}>{pillar.body}</p>
              {pillar.tag && <p className={styles.pillarTag}>{pillar.tag}</p>}
            </article>
          ))}
        </div>

        <div className={styles.metrics}>
          {METRICS.map((metric) => (
            <div key={metric.label} className={styles.metric}>
              <span className={styles.metricValue}>{metric.value}</span>
              <span className={styles.metricLabel}>{metric.label}</span>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
