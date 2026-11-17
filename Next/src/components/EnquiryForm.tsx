"use client";

import { useState, type FormEvent } from "react";
import Image from "next/image";
import styles from "./EnquiryForm.module.css";
import type { CustomiserConfig } from "../data/catalogue";
import {
  getModel,
  getFabric,
  getSeating,
  getColour,
  calculatePrice,
  formatPrice,
} from "../data/catalogue";

interface EnquiryFormProps {
  config: CustomiserConfig;
}

interface Errors {
  name?: string;
  phone?: string;
  email?: string;
  message?: string;
}

export default function EnquiryForm({ config }: EnquiryFormProps) {
  const [submitted, setSubmitted] = useState(false);
  const [errors, setErrors] = useState<Errors>({});
  const [swatchKit, setSwatchKit] = useState(false);

  const model = getModel(config.modelId);
  const fabric = getFabric(config.fabricId);
  const seating = getSeating(config.seatingId);
  const colour = getColour(model, config.colourId);
  const price = calculatePrice(config);

  const validate = (data: FormData): Errors => {
    const next: Errors = {};
    const name = String(data.get("name") ?? "").trim();
    const phone = String(data.get("phone") ?? "").trim();
    const email = String(data.get("email") ?? "").trim();
    const message = String(data.get("message") ?? "").trim();

    if (!name) next.name = "Full name is required.";
    if (!phone) next.phone = "Phone number is required.";
    else if (!/^\d{10}$/.test(phone))
      next.phone = "Enter a valid 10-digit phone number.";
    if (!email) next.email = "Email address is required.";
    else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email))
      next.email = "Enter a valid email address.";
    if (!message) next.message = "Please add a short message.";

    return next;
  };

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    const found = validate(data);
    setErrors(found);
    if (Object.keys(found).length === 0) {
      // Frontend only: nothing is sent anywhere.
      setSubmitted(true);
    }
  };

  if (submitted) {
    return (
      <section className={styles.section} id="enquiry">
        <div className={styles.success}>
          <Image
            src="/images/icon-check.svg"
            alt=""
            width={48}
            height={48}
          />
          <h2 className={styles.heading}>Enquiry Received</h2>
          <p className={styles.successBody}>
            Thank you. Our design consultants will reach out within 24 hours to
            discuss your configuration.
          </p>
        </div>
      </section>
    );
  }

  return (
    <section className={styles.section} id="enquiry">
      <div className={styles.header}>
        <p className={styles.eyebrow}>Book a Private Consultation</p>
        <h2 className={styles.heading}>Enquire About Your Bespoke Sofa</h2>
        <p className={styles.subheading}>
          Share your room dimensions and our atelier team will return a
          tailored quotation within 24 hours.
        </p>
      </div>

      <div className={styles.formCard}>
        <form className={styles.form} onSubmit={handleSubmit} noValidate>
          <div className={styles.row}>
            <div className={styles.field}>
              <label className={styles.label} htmlFor="name">
                Full Name *
              </label>
              <input
                className={styles.input}
                id="name"
                name="name"
                type="text"
                placeholder="e.g. Ananya Sen"
                autoComplete="name"
                required
              />
              {errors.name && <p className={styles.error}>{errors.name}</p>}
            </div>

            <div className={styles.field}>
              <label className={styles.label} htmlFor="phone">
                Phone Number (+91) *
              </label>
              <input
                className={styles.input}
                id="phone"
                name="phone"
                type="tel"
                placeholder="9876543210 (10 digits)"
                autoComplete="tel"
                required
              />
              {errors.phone && <p className={styles.error}>{errors.phone}</p>}
            </div>
          </div>

          <div className={styles.field}>
            <label className={styles.label} htmlFor="email">
              Email Address *
            </label>
            <input
              className={styles.input}
              id="email"
              name="email"
              type="email"
              placeholder="ananya@architecturestudio.in"
              autoComplete="email"
              required
            />
            {errors.email && <p className={styles.error}>{errors.email}</p>}
          </div>

          {/* Customiser Synchronized Fields Grid — mirrors the live selection */}
          <div className={styles.syncBox}>
            <div className={styles.syncTop}>
              <span className={styles.syncLabel}>
                Synced From Your Customiser
              </span>
              <span className={styles.syncHint}>
                Updates automatically
              </span>
            </div>
            <div className={styles.syncRow}>
              <div className={styles.syncField}>
                <span className={styles.syncFieldLabel}>Model Selection</span>
                <span className={styles.syncValue}>{model.displayName}</span>
              </div>
              <div className={styles.syncField}>
                <span className={styles.syncFieldLabel}>Fabric &amp; Colour</span>
                <span className={styles.syncValue}>
                  {fabric.displayLabel} · {colour?.label}
                </span>
              </div>
              <div className={styles.syncField}>
                <span className={styles.syncFieldLabel}>Seating Size</span>
                <span className={styles.syncValue}>
                  {seating.stageLabel}
                </span>
              </div>
            </div>
          </div>

          <div className={styles.row}>
            <div className={styles.field}>
              <label className={styles.label} htmlFor="delivery">
                Delivery City &amp; Pincode *
              </label>
              <input
                className={styles.input}
                id="delivery"
                name="delivery"
                type="text"
                placeholder="e.g. Bangalore, 560038"
              />
            </div>

            <div className={styles.field}>
              <label className={styles.label} htmlFor="message">
                Special Dimensions or Room Requirements (Optional)
              </label>
              <input
                className={styles.input}
                id="message"
                name="message"
                type="text"
                required
              />
              {errors.message && (
                <p className={styles.error}>{errors.message}</p>
              )}
            </div>
          </div>

          <label className={styles.checkboxRow}>
            <input
              className={styles.checkbox}
              type="checkbox"
              name="swatchKit"
              checked={swatchKit}
              onChange={(e) => setSwatchKit(e.target.checked)}
            />
            <span className={styles.checkboxText}>
              Send a complimentary physical fabric swatch box (including the
              chosen fabric and 3 curated alternatives) to my delivery address
              at zero cost.
            </span>
          </label>

          <button type="submit" className={styles.submit}>
            <span>Submit Bespoke Enquiry</span>
            <Image
              src="/images/icon-submit.svg"
              alt=""
              width={11}
              height={10}
            />
          </button>

          <p className={styles.footerNote}>
            Protected by end-to-end craft confidentiality. No marketing spam.
          </p>
        </form>
      </div>
    </section>
  );
}
