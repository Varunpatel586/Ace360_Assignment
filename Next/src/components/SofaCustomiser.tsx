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
      <div className={styles.header}>
        <div className={styles.badgePill}>
          <Image src="/images/icon-badge-5.svg" alt="" width={7} height={12} />
          <span>Personalise Your Piece</span>
        </div>
        <h2 className={styles.heading}>Build Your Bespoke Sofa</h2>
        <p className={styles.subheading}>
          Four deliberate choices — silhouette, colour, fabric and footprint.
          Every selection updates your live specification and artisan estimate
          instantly.
        </p>
      </div>

      <div className={styles.grid}>
        {/* LEFT COLUMN: stage card + price ribbon + artisan note */}
        <div className={styles.leftCol}>
          <div className={styles.stageCard}>
            <div className={styles.stage}>
              <Image
                src={model.image}
                alt={`Live customizer preview of ${model.displayName} in ${colour?.label ?? ""}`}
                width={1044}
                height={783}
                className={styles.stageImage}
              />

              <div className={styles.stageTags}>
                <span className={styles.tagPill}>{model.name} Model</span>
                <span className={styles.tagPill}>
                  <span
                    className={styles.tagDot}
                    style={{ background: colour?.hex }}
                  />
                  {colour?.label}
                </span>
              </div>

              <span className={`${styles.tagPill} ${styles.stageRight}`}>
                {seating.stageLabel}
              </span>

              <div className={styles.stageBottom}>
                <span className={styles.darkPill}>360° Inspection Ready</span>
                <span className={styles.lightPill}>
                  Ships in 6–8 Weeks
                </span>
              </div>
            </div>

            <div className={styles.priceRibbon}>
              <div>
                <p className={styles.ribbonLabel}>YOUR BESPOKE QUOTE</p>
                <p className={styles.ribbonPrice}>
                  {formatPrice(price.total)}
                  <span className={styles.ribbonGst}>incl. GST</span>
                </p>
              </div>
              <span className={styles.gstPill}>GST Compliant Invoice</span>
            </div>
          </div>

          <div className={styles.artisanNote}>
            <Image src="/images/icon-badge-6.svg" alt="" width={15} height={19} />
            <p>
              Every frame is hand-built to order in our Bangalore and Mumbai
              workshops. Configuration changes may adjust lead time by up to two
              weeks.
            </p>
          </div>
        </div>

        {/* RIGHT COLUMN: the 4-step engine */}
        <div className={styles.panel}>
          {/* STEP 1: MODEL SELECTION */}
          <div className={styles.step}>
            <div className={styles.stepTop}>
              <span className={styles.stepLabel}>Step 01</span>
              <span className={styles.stepHint}>Base Architecture</span>
            </div>
            <h3 className={styles.stepHeading}>Choose Sofa Model</h3>
            <div className={styles.modelRow}>
              {SOFA_MODELS.map((m) => {
                const active = m.id === config.modelId;
                return (
                  <button
                    key={m.id}
                    type="button"
                    className={`${styles.modelCard} ${active ? styles.modelCardActive : ""
                      }`}
                    onClick={() => setModel(m.id)}
                  >
                    <span className={styles.modelTop}>
                      <span className={styles.modelName}>{m.name}</span>
                      {active && (
                        <Image
                          src="/images/icon-check.svg"
                          alt=""
                          width={13}
                          height={13}
                        />
                      )}
                    </span>
                    <span className={styles.modelDesc}>
                      {m.shortDesc}
                    </span>
                    <span className={styles.modelPrice}>
                      {formatPrice(m.basePrice)}
                    </span>
                  </button>
                );
              })}
            </div>
          </div>

          <div className={styles.separator} />

          {/* STEP 2: FABRIC COLOUR */}
          <div className={styles.step}>
            <div className={styles.stepTop}>
              <span className={styles.stepLabel}>Step 02</span>
              <span className={styles.stepHint}>{colour?.label}</span>
            </div>
            <h3 className={styles.stepHeading}>Choose Fabric Colour</h3>
            <div className={styles.swatchRow}>
              {model.colours.map((c) => (
                <button
                  key={c.id}
                  type="button"
                  className={styles.swatchBtn}
                  aria-pressed={c.id === config.colourId}
                  onClick={() => setColour(c.id)}
                >
                  <span
                    className={`${styles.swatch} ${c.id === config.colourId ? styles.swatchSelected : ""
                      }`}
                    style={{ background: c.hex }}
                  >
                    {c.id === config.colourId && (
                      <Image
                        src="/images/icon-check.svg"
                        alt=""
                        width={9}
                        height={7}
                      />
                    )}
                  </span>
                  <span className={styles.swatchLabel}>
                    {c.shortLabel}
                  </span>
                </button>
              ))}
            </div>
          </div>

          <div className={styles.separator} />

          {/* STEP 3: FABRIC TYPE */}
          <div className={styles.step}>
            <div className={styles.stepTop}>
              <span className={styles.stepLabel}>Step 03</span>
              <span className={styles.stepHint}>Material Tactility</span>
            </div>
            <h3 className={styles.stepHeading}>Choose Fabric Type</h3>
            <div className={styles.optionList}>
              {FABRICS.map((f) => (
                <button
                  key={f.id}
                  type="button"
                  className={`${styles.optionBtn} ${f.id === config.fabricId ? styles.optionActive : ""
                    }`}
                  onClick={() => setFabric(f.id)}
                >
                  <span
                    className={`${styles.radio} ${f.id === config.fabricId ? styles.radioActive : ""
                      }`}
                  />
                  <span className={styles.optionText}>
                    <span className={styles.optionName}>{f.displayLabel}</span>
                    <span className={styles.optionDesc}>{f.description}</span>
                  </span>
                  <span
                    className={`${styles.optionPrice} ${f.id === config.fabricId ? "" : styles.optionPriceAlt
                      }`}
                  >
                    {f.priceLabel}
                  </span>
                </button>
              ))}
            </div>
          </div>

          <div className={styles.separator} />

          {/* STEP 4: SEATING CONFIGURATION */}
          <div className={styles.step}>
            <div className={styles.stepTop}>
              <span className={styles.stepLabel}>Step 04</span>
              <span className={styles.stepHint}>Spatial Footprint</span>
            </div>
            <h3 className={styles.stepHeading}>Choose Seating Configuration</h3>
            <div className={styles.seatRow}>
              {SEATING.map((s) => (
                <button
                  key={s.id}
                  type="button"
                  className={`${styles.seatCard} ${s.id === config.seatingId ? styles.optionActive : ""
                    }`}
                  onClick={() => setSeating(s.id)}
                >
                  <span className={styles.optionName}>{s.label}</span>
                  <span className={styles.optionDesc}>{s.description}</span>
                  <span
                    className={`${styles.seatPrice} ${s.adjustment < 0 ? styles.priceGreen : ""
                      }`}
                  >
                    {s.priceLabel}
                  </span>
                </button>
              ))}
            </div>
          </div>

          {/* DYNAMIC SUMMARY BOX */}
          <div className={styles.summary}>
            <div className={styles.summaryTop}>
              <span className={styles.summaryLabel}>Configuration Summary</span>
              <span className={styles.summaryChip}>Live Estimate</span>
            </div>

            <p className={styles.summaryString}>
              The {model.name} · {colour?.label} · {fabric.displayLabel} ·{
                " "
              }
              {seating.label}
            </p>

            <dl className={styles.lineItems}>
              <div className={styles.line}>
                <dt>Base Architecture ({model.name})</dt>
                <dd>{formatPrice(price.base)}</dd>
              </div>
              <div className={styles.line}>
                <dt>Fabric Tier ({fabric.displayLabel})</dt>
                <dd>{formatPrice(price.fabricAdj)}</dd>
              </div>
              <div className={styles.line}>
                <dt>Seating Configuration ({seating.label})</dt>
                <dd>{formatPrice(price.seatingAdj)}</dd>
              </div>
              <div className={`${styles.line} ${styles.totalLine}`}>
                <dt>Total Estimate (incl. GST)</dt>
                <dd>{formatPrice(price.total)}</dd>
              </div>
            </dl>

            <a href="#enquiry" className={styles.syncCta}>
              Sync Selection to Enquiry Form
              <Image
                src="/images/icon-arrow-sm.svg"
                alt=""
                width={9}
                height={9}
              />
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}
