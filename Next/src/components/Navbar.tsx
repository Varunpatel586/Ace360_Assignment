"use client";

import { useState } from "react";
import styles from "./Navbar.module.css";

const LINKS = [
  { label: "Collections", href: "#collections", active: true },
  { label: "Customiser", href: "#customiser", active: false },
  { label: "Craftsmanship", href: "#craftsmanship", active: false },
  { label: "Enquiry", href: "#enquiry", active: false },
];

export default function Navbar() {
  const [open, setOpen] = useState(false);

  return (
    <header className={styles.header}>
      <div className={styles.inner}>
        <a href="#top" className={styles.brand}>
          <span className={styles.brandSerif}>SOFALIVING</span>
          <span className={styles.brandTag}>EST. 1998 · BESPOKE CRAFT</span>
        </a>

        <nav className={styles.nav} aria-label="Main navigation">
          {LINKS.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className={`${styles.navItem} ${link.active ? styles.navItemActive : ""
                }`}
            >
              {link.label}
            </a>
          ))}
        </nav>

        <div className={styles.actions}>
          <a href="tel:+919876543210" className={styles.phone}>
            +91 98765 43210
          </a>
          <a href="#enquiry" className={styles.cta}>
            Design Yours
          </a>
        </div>

        <button
          className={styles.burger}
          aria-expanded={open}
          aria-label="Toggle menu"
          onClick={() => setOpen(!open)}
        >
          <span />
          <span />
          <span />
        </button>
      </div>

      {open && (
        <nav className={styles.mobileNav} aria-label="Mobile navigation">
          {LINKS.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className={styles.link}
              onClick={() => setOpen(false)}
            >
              {link.label}
            </a>
          ))}
        </nav>
      )}
    </header>
  );
}
