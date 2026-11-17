"use client";

import Image from "next/image";
import type { SofaModel } from "../data/catalogue";
import { formatPrice } from "../data/catalogue";
import styles from "./SofaCard.module.css";

interface SofaCardProps {
  model: SofaModel;
  onCustomise: (modelId: SofaModel["id"]) => void;
}

export default function SofaCard({ model, onCustomise }: SofaCardProps) {
  return (
    <article className={styles.card}>
      <div className={styles.imageWrap}>
        <Image
          src={model.image}
          alt={model.displayName}
          width={1200}
          height={900}
          className={styles.image}
        />
        <span className={styles.tag}>{model.tag}</span>
      </div>

      <div className={styles.body}>
        <div className={styles.titleRow}>
          <h3 className={styles.name}>{model.displayName}</h3>
          <span className={styles.price}>{formatPrice(model.basePrice)}</span>
        </div>
        <p className={styles.description}>{model.description}</p>
        <ul className={styles.badges}>
          {model.badges.map((badge) => (
            <li key={badge} className={styles.badge}>
              {badge}
            </li>
          ))}
        </ul>
        <button
          type="button"
          className={styles.cta}
          onClick={() => onCustomise(model.id)}
        >
          Customise {model.name}
        </button>
      </div>
    </article>
  );
}
