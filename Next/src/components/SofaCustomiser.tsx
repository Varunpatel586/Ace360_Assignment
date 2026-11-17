"use client";

import Image from "next/image";
import styles from "./SofaCustomiser.module.css";
import {
  SOFA_MODELS,
  FABRICS,
  SEATING,
  getModel,
  getFabric,
  getSeating,
  getColour,
  calculatePrice,
  formatPrice,
  formatAdjustment,
  type CustomiserConfig,
  type ModelId,
  type FabricId,
  type SeatingId,
} from "../data/catalogue";

interface SofaCustomiserProps {
  config: CustomiserConfig;
  onChange: (config: CustomiserConfig) => void;
}

export default function SofaCustomiser({
  config,
  onChange,
}: SofaCustomiserProps) {
  const model = getModel(config.modelId);
  const fabric = getFabric(config.fabricId);
  const seating = getSeating(config.seatingId);
  const colour = getColour(model, config.colourId);
  const price = calculatePrice(config);

  const setModel = (id: ModelId) => {
    const next = getModel(id);
    // Reset colour if it is not offered by the new model
    const colourValid = getColour(next, config.colourId);
    onChange({
      ...config,
      modelId: id,
      colourId: colourValid ? config.colourId : next.colours[0].id,
    });
  };

  const setColour = (colourId: string) =>
    onChange({ ...config, colourId });
  const setFabric = (fabricId: FabricId) =>
    onChange({ ...config, fabricId });
  const setSeating = (seatingId: SeatingId) =>
    onChange({ ...config, seatingId });

  return (
    <section className={styles.section} id="customiser">
      <div className={styles.headingRow}>
        <h2 className={styles.heading}>Interactive Customiser</h2>
        <p className={styles.subheading}>
          Configure your sofa in four steps and watch the quote update live.
        </p>
      </div>

      <div className={styles.grid}>
        {/* LEFT: live preview stage */}
        <div className={styles.stage}>
          <Image
            src={model.image}
            alt={`${model.displayName} in ${colour?.label ?? "selected colour"}`}
            width={1200}
            height={900}
            className={styles.stageImage}
          />
          <div className={styles.stageMeta}>
            <span className={styles.stageTag}>{model.name} Model</span>
            <span className={styles.stageMetaItem}>
              {colour?.label ?? "—"}
            </span>
            <span className={styles.stageMetaItem}>{seating.stageLabel}</span>
          </div>
          <span className={styles.stageBadge}>360° Inspection Ready</span>
        </div>

        {/* RIGHT: 4-step engine */}
        <div className={styles.panel}>
          {/* STEP 01 — model */}
          <div className={styles.step}>
            <p className={styles.stepLabel}>STEP 01/04</p>
            <h3 className={styles.stepHeading}>Choose Sofa Model</h3>
            <div className={styles.optionList}>
              {SOFA_MODELS.map((m) => (
                <button
                  key={m.id}
                  type="button"
                  className={`${styles.modelPill} ${
                    m.id === config.modelId ? styles.selected : ""
                  }`}
                  onClick={() => setModel(m.id)}
                >
                  <span className={styles.modelName}>{m.name}</span>
                  <span className={styles.modelPrice}>
                    {formatPrice(m.basePrice)}
                  </span>
                </button>
              ))}
            </div>
          </div>

          {/* STEP 02 — colour */}
          <div className={styles.step}>
            <p className={styles.stepLabel}>STEP 02/04</p>
            <h3 className={styles.stepHeading}>Choose Colour</h3>
            <div className={styles.swatchRow}>
              {model.colours.map((c) => (
                <button
                  key={c.id}
                  type="button"
                  aria-label={c.label}
                  title={c.label}
                  className={`${styles.swatch} ${
                    c.id === config.colourId ? styles.swatchSelected : ""
                  }`}
                  style={{ background: c.hex }}
                  onClick={() => setColour(c.id)}
                />
              ))}
            </div>
            <p className={styles.swatchName}>{colour?.label}</p>
          </div>

          {/* STEP 03 — fabric */}
          <div className={styles.step}>
            <p className={styles.stepLabel}>STEP 03/04</p>
            <h3 className={styles.stepHeading}>Material Tactility</h3>
            <div className={styles.optionList}>
              {FABRICS.map((f) => (
                <button
                  key={f.id}
                  type="button"
                  className={`${styles.optionBtn} ${
                    f.id === config.fabricId ? styles.selected : ""
                  }`}
                  onClick={() => setFabric(f.id)}
                >
                  <span className={styles.modelName}>{f.displayLabel}</span>
                  <span className={styles.modelPrice}>
                    {formatAdjustment(f.adjustment)}
                  </span>
                </button>
              ))}
            </div>
          </div>

          {/* STEP 04 — seating */}
          <div className={styles.step}>
            <p className={styles.stepLabel}>STEP 04/04</p>
            <h3 className={styles.stepHeading}>Spatial Footprint</h3>
            <div className={styles.optionList}>
              {SEATING.map((s) => (
                <button
                  key={s.id}
                  type="button"
                  className={`${styles.optionBtn} ${
                    s.id === config.seatingId ? styles.selected : ""
                  }`}
                  onClick={() => setSeating(s.id)}
                >
                  <span className={styles.modelName}>{s.label}</span>
                  <span className={styles.modelPrice}>
                    {formatAdjustment(s.adjustment)}
                  </span>
                </button>
              ))}
            </div>
          </div>

          {/* Price summary */}
          <div className={styles.summary}>
            <div className={styles.summaryHeader}>
              <span className={styles.liveBadge}>Live Quote</span>
              <p className={styles.summaryConfig}>
                The {model.name} · {colour?.label} · {fabric.displayLabel} ·{" "}
                {seating.label}
              </p>
            </div>
            <dl className={styles.lineItems}>
              <div className={styles.line}>
                <dt>Base Architecture ({model.name})</dt>
                <dd>{formatPrice(price.base)}</dd>
              </div>
              <div className={styles.line}>
                <dt>Fabric Tier ({fabric.displayLabel})</dt>
                <dd>{formatAdjustment(price.fabricAdj)}</dd>
              </div>
              <div className={styles.line}>
                <dt>Seating Configuration ({seating.label})</dt>
                <dd>{formatAdjustment(price.seatingAdj)}</dd>
              </div>
              <div className={`${styles.line} ${styles.totalLine}`}>
                <dt>Total</dt>
                <dd>{formatPrice(price.total)}</dd>
              </div>
            </dl>
          </div>
        </div>
      </div>
    </section>
  );
}
