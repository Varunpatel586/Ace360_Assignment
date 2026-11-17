"use client";

import { useState } from "react";
import styles from "./Navbar.module.css";

const LINKS = [
  { label: "Collections", href: "#collections" },
  { label: "Customiser", href: "#customiser" },
  { label: "Craftsmanship", href: "#craftsmanship" },
  { label: "Enquire", href: "#enquiry" },
];

export default function Navbar() {
  const [open, setOpen] = useState(false);

  return (
    <header className={styles.header}>
      <div className={styles.inner}>
        <a href="#top" className={styles.brand}>
          <span className={styles.brandSerif}>SOFALIVING</span>
          <span className={styles.brandDot}>®</span>
        </a>

        <nav className={styles.nav} aria-label="Main navigation">
          {LINKS.map((link) => (
            <a key={link.href} href={link.href} className={styles.link}>
              {link.label}
            </a>
          ))}
        </nav>

        <a href="#customiser" className={styles.cta}>
          Start Customising
        </a>

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
