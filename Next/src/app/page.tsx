"use client";

import { useState } from "react";
import Navbar from "../components/Navbar";
import Hero from "../components/Hero";
import SofaCard from "../components/SofaCard";
import SofaCustomiser from "../components/SofaCustomiser";
import Craftsmanship from "../components/Craftsmanship";
import EnquiryForm from "../components/EnquiryForm";
import Footer from "../components/Footer";
import { SOFA_MODELS, DEFAULT_CONFIG, type CustomiserConfig, type ModelId } from "../data/catalogue";
import styles from "./page.module.css";

export default function Home() {
  // Single source of truth for the customiser state, shared with the
  // sofa cards (Customise button selects the model) and the enquiry summary.
  const [config, setConfig] = useState<CustomiserConfig>(DEFAULT_CONFIG);

  const selectModel = (modelId: ModelId) => {
    const model = SOFA_MODELS.find((m) => m.id === modelId)!;
    setConfig((prev) => ({
      ...prev,
      modelId,
      // Reset colour if the new model does not offer the current one
      colourId: model.colours.some((c) => c.id === prev.colourId)
        ? prev.colourId
        : model.colours[0].id,
    }));
    document.getElementById("customiser")?.scrollIntoView({ behavior: "smooth" });
  };

  return (
    <>
      <Navbar />
      <main>
        <Hero />

        <section className={styles.collections} id="collections">
          <div className={styles.collectionsHead}>
            <h2 className={styles.sectionHeading}>Signature Collections</h2>
            <p className={styles.sectionSub}>
              Explore our foundational silhouettes, engineered for ergonomic
              posture and architectural presence.
            </p>
          </div>
          <div className={styles.cardGrid}>
            {SOFA_MODELS.map((model) => (
              <SofaCard key={model.id} model={model} onCustomise={selectModel} />
            ))}
          </div>
        </section>

        <SofaCustomiser config={config} onChange={setConfig} />
        <Craftsmanship />
        <EnquiryForm config={config} />
      </main>
      <Footer />
    </>
  );
}
