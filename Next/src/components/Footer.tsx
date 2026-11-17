import styles from "./Footer.module.css";

const LINKS = [
  { label: "Collections", href: "#collections" },
  { label: "Customiser", href: "#customiser" },
  { label: "Craftsmanship", href: "#craftsmanship" },
  { label: "Enquire", href: "#enquiry" },
];

export default function Footer() {
  return (
    <footer className={styles.footer}>
      <div className={styles.inner}>
        <div className={styles.brandCol}>
          <span className={styles.brand}>SOFALIVING</span>
          <p className={styles.note}>
            Bespoke sofas, sculpted for modern Indian homes.
          </p>
        </div>

        <nav className={styles.nav} aria-label="Footer navigation">
          {LINKS.map((link) => (
            <a key={link.href} href={link.href} className={styles.link}>
              {link.label}
            </a>
          ))}
        </nav>
      </div>

      <p className={styles.copyright}>
        © 2026 SOFALIVING. All rights reserved.
      </p>
    </footer>
  );
}
