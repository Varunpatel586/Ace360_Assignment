import Image from "next/image";
import styles from "./Craftsmanship.module.css";

/* Copy taken verbatim from the Figma "Built by Indian Artisans" section. */

const PILLARS = [
  {
    icon: "/images/icon-badge-7.svg",
    iconWidth: 22,
    iconHeight: 19,
    title: "Kiln-Dried Hardwood",
    body: "0% moisture seasoned Teak and Sal wood with reinforced mortise-and-tenon corner joints. Termite-proofed for lasting structural peace of mind.",
    foot: "Grade A Solid Timber",
  },
  {
    icon: "/images/icon-badge-8.svg",
    iconWidth: 17,
    iconHeight: 19,
    title: "38-Density Cold Foam",
    body: "Multi-layer cold-cure memory foam cores supported by S-spring suspension bands. Maintains rebound resilience and anatomical contour for 15+ years.",
    foot: "15+ Year Rebound Life",
  },
  {
    icon: "/images/icon-badge-9.svg",
    iconWidth: 15,
    iconHeight: 19,
    title: "50k Martindale Rubs",
    body: "Pet-friendly weaves tested against heavy abrasion and accidental spills. Oleophobic treatments resist coffee, wine, and daily family wear.",
    foot: "Commercial-Grade Weave",
  },
  {
    icon: "/images/icon-badge-10.svg",
    iconWidth: 17,
    iconHeight: 17,
    title: "Direct from Factory",
    body: "Direct atelier-to-residence model skips middlemen markups. You invest purely in authentic timber, foam grade, and generational craft.",
    foot: "Zero Distributor Margin",
  },
];

const METRICS = [
  { value: "26", label: "Years of Craftsmanship" },
  { value: "4,200+", label: "Homes Furnished" },
  { value: "10-Yr", label: "Frame Warranty" },
  { value: "100%", label: "Factory Direct" },
];

export default function Craftsmanship() {
  return (
    <section className={styles.section} id="craftsmanship">
      <div className={styles.inner}>
        <div className={styles.header}>
          <p className={styles.eyebrow}>Manufacturer Direct</p>
          <h2 className={styles.heading}>
            Built by Indian Artisans, Engineered to Last Generations.
          </h2>
          <p className={styles.subheading}>
            Unlike mass-manufactured flatpack imports, SOFALIVING constructs
            seating with architectural joinery, seasoned timber, and tailored
            upholstery executed by third-generation woodworkers and upholsterers
            in Bangalore and Mumbai.
          </p>
        </div>

        <div className={styles.pillars}>
          {PILLARS.map((pillar) => (
            <article key={pillar.title} className={styles.pillar}>
              <span className={styles.pillarIcon}>
                <Image
                  src={pillar.icon}
                  alt=""
                  width={pillar.iconWidth}
                  height={pillar.iconHeight}
                />
              </span>
              <h3 className={styles.pillarTitle}>{pillar.title}</h3>
              <p className={styles.pillarBody}>{pillar.body}</p>
              <p className={styles.pillarFoot}>{pillar.foot}</p>
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
