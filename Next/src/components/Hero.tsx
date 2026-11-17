"use client";

import Image from "next/image";
import styles from "./Hero.module.css";

export default function Hero() {
  return (
    <section className={styles.section} id="top">
      <div className={styles.inner}>
        <div className={styles.textCol}>

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
              <span className={styles.ctaText}>Start Customising</span>
              <Image
                src="/images/icon-arrow.svg"
                alt=""
                width={10}
                height={10}
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
          alt="Minimalist architectural living room featuring a tailored bespoke oat-linen 3-seater sofa with wood accent table and daylight arch window"
          width={2300}
          height={1240}
          priority
          className={styles.heroImage}
        />
        <div className={styles.badge}>
          <Image
            src="/images/icon-badge-1.svg"
            alt=""
            width={18}
            height={14}
          />
          <div>
            <p className={styles.badgeLabel}>LIVING ROOM SHOWCASE</p>
            <p className={styles.badgeTitle}>
              The Nordic Minimalist 3-Seater in Oat Linen
            </p>
          </div>
        </div>
      </div>

      <div className={styles.trustRibbon}>
        <div className={styles.trustItem}>
          <Image src="/images/icon-badge-2.svg" alt="" width={21} height={20} />
          <span>Kiln-Dried Hardwood Frames</span>
        </div>
        <div className={styles.trustItem}>
          <Image src="/images/icon-badge-3.svg" alt="" width={17} height={17} />
          <span>120+ Artisan Fabrics</span>
        </div>
        <div className={styles.trustItem}>
          <Image src="/images/icon-badge-4.svg" alt="" width={21} height={15} />
          <span>10-Year Structural Warranty</span>
        </div>
      </div>
    </section>
  );
}
