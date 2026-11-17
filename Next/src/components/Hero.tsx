"use client";

import Image from "next/image";
import styles from "./Hero.module.css";

export default function Hero() {
  return (
    <section className={styles.section} id="top">
      <div className={styles.inner}>
        <div className={styles.textCol}>
          <p className={styles.eyebrow}>SOFALIVING — BESPOKE SEATING ATELIER</p>
          <h1 className={styles.heading}>
            Bespoke Sofas, Sculpted for Modern Indian Homes.
          </h1>
          <p className={styles.subheading}>
            Explore precision-tailored seating crafted with kiln-dried teak
            frames, high-density feather core foams, and over 120 artisan
            fabrics. Customise dimensions, fabrics, and contours in real-time.
          </p>
          <div className={styles.ctas}>
            <a href="#customiser" className={styles.primaryCta}>
              Start Customising
              <Image
                src="/images/icon-arrow.svg"
                alt=""
                width={14}
                height={14}
              />
            </a>
            <a href="#collections" className={styles.secondaryCta}>
              Explore Signature Models
            </a>
          </div>
        </div>
      </div>

      <div className={styles.imageFrame}>
        <Image
          src="/images/hero-sofa.png"
          alt="The Nordic Minimalist 3-Seater in Oat Linen in a minimalist living room"
          width={2304}
          height={1276}
          priority
          className={styles.heroImage}
        />
        <div className={styles.badge}>
          <p className={styles.badgeLabel}>LIVING ROOM SHOWCASE</p>
          <p className={styles.badgeTitle}>
            The Nordic Minimalist 3-Seater in Oat Linen
          </p>
        </div>
      </div>
    </section>
  );
}
