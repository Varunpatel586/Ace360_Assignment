import styles from "./Footer.module.css";

/* Footer copy taken verbatim from the Figma footer. */

const FOOTER_LINKS = [
  { label: "Crafting & Material Guide", href: "#craftsmanship" },
  { label: "Delivery Policy", href: "#ship" },
  { label: "Warranty Terms", href: "#ship" },
  { label: "Care & Maintenance", href: "#craftsmanship" },
  { label: "Privacy", href: "#legal" },
];

export default function Footer() {
  return (
    <footer className={styles.footer}>
      <div className={styles.inner}>
        <div className={styles.topGrid}>
          <div className={styles.brandCol}>
            <span className={styles.brand}>SOFALIVING</span>
            <p className={styles.note}>
              Architectural seating crafted in India. Built by
              third-generation artisans with seasoned hardwood, cold-cure foam
              and 120+ artisan fabrics — delivered direct from our ateliers in
              Bangalore and Mumbai.
            </p>
            <div className={styles.contactLines}>
              <span>Direct Workshop: +91 98765 43210 (10:00 AM – 7:30 PM IST)</span>
              <span>Trade Desk: trade@sofaliving.in</span>
            </div>
          </div>

          <div className={styles.col}>
            <span className={styles.colTitle}>Atelier Experience Studios</span>
            <ul className={styles.list}>
              <li>Bangalore: 100ft Road, Indiranagar, 560038</li>
              <li>Mumbai: Mathuradas Mill Compound, Lower Parel, 400013</li>
              <li>Delhi NCR: The Gallery on MG, Sultanpur, New Delhi 110030</li>
            </ul>
          </div>

          <div className={styles.col}>
            <span className={styles.colTitle}>Architect &amp; Trade Desk</span>
            <p className={styles.colBody}>
              Specialized 3D asset packs (Revit / Rhino / 3ds Max) and volume
              project rates available for registered architects and interior
              studios.
            </p>
            <a href="#enquiry" className={styles.tradeLink}>
              Apply for Trade Account →
            </a>
          </div>
        </div>

        <div className={styles.linksRow}>
          <nav className={styles.nav} aria-label="Footer navigation">
            {FOOTER_LINKS.map((link) => (
              <a key={link.label} href={link.href} className={styles.link}>
                {link.label}
              </a>
            ))}
          </nav>
          <span className={styles.linksNote}>
            Handcrafted in India · GST Compliant Invoicing
          </span>
        </div>

        <div className={styles.copyRow}>
          <p className={styles.copyright}>
            © 2026 SOFALIVING Furniture Ateliers Pvt. Ltd. All rights reserved.
          </p>
          <span className={styles.linksNote}>
            Bespoke Lead Times · 6–8 Weeks
          </span>
        </div>
      </div>
    </footer>
  );
}
