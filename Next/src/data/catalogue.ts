// Single source of truth for all sofa data and pricing.
// Prices and adjustments come from the assignment brief (B1) and Figma;
// all amounts are stored as plain numbers (rupees) and formatted at render time.

export type ModelId = "luna" | "urban" | "cloud";
export type ColourId = string;
export type FabricId = "linen" | "velvet" | "leatherette";
export type SeatingId = "two-seater" | "three-seater" | "l-shape";

export interface ColourOption {
  id: ColourId;
  label: string;
  hex: string;
}

export interface FabricOption {
  id: FabricId;
  label: string;
  displayLabel: string;
  adjustment: number;
  summaryLabel: string;
}

export interface SeatingOption {
  id: SeatingId;
  label: string;
  adjustment: number;
  stageLabel: string;
}

export interface SofaModel {
  id: ModelId;
  name: string;
  displayName: string;
  basePrice: number;
  description: string;
  tag: string;
  badges: string[];
  image: string;
  colours: ColourOption[];
}

export const SOFA_MODELS: SofaModel[] = [
  {
    id: "luna",
    name: "Luna",
    displayName: "The Luna Curved",
    basePrice: 42999,
    description:
      "Organic curved silhouette enveloped in soft, tactile boucle. Ideal for fluid, conversational open-plan spaces.",
    tag: "Curved Artistry",
    badges: ["Curved Silhouette", "High-Traffic Boucle", "Soft Density"],
    image: "/images/luna-sofa.png",
    colours: [
      { id: "beige", label: "Warm Beige", hex: "#d9cfc0" },
      { id: "charcoal", label: "Slate Charcoal", hex: "#4e5258" },
      { id: "olive", label: "Olive Moss", hex: "#556346" },
      { id: "midnight", label: "Midnight Blue", hex: "#283b4b" },
    ],
  },
  {
    id: "urban",
    name: "Urban",
    displayName: "The Urban Mid-Century",
    basePrice: 54999,
    description:
      "Mid-century clean lines with solid walnut trim and firm ergonomic support.",
    tag: "Mid-Century Clean Lines",
    badges: ["Mid-Century Clean Lines", "Solid Walnut Trim", "Firm Ergonomic Support"],
    image: "/images/urban-sofa.png",
    colours: [
      { id: "beige", label: "Warm Beige", hex: "#d9cfc0" },
      { id: "charcoal", label: "Slate Charcoal", hex: "#4e5258" },
      { id: "olive", label: "Olive Moss", hex: "#556346" },
      { id: "midnight", label: "Midnight Blue", hex: "#283b4b" },
    ],
  },
  {
    id: "cloud",
    name: "Cloud",
    displayName: "The Cloud Sectional",
    basePrice: 64999,
    description:
      "Deep lounge sanctuary with cloud softness and an L-shape ready footprint.",
    tag: "Deep Sanctuary",
    badges: ["Deep Sanctuary", "Cloud Softness", "L-Shape Ready"],
    image: "/images/cloud-sofa.png",
    colours: [
      { id: "beige", label: "Warm Beige", hex: "#d9cfc0" },
      { id: "charcoal", label: "Slate Charcoal", hex: "#4e5258" },
      { id: "olive", label: "Olive Moss", hex: "#556346" },
      { id: "midnight", label: "Midnight Blue", hex: "#283b4b" },
    ],
  },
];

export const FABRICS: FabricOption[] = [
  {
    id: "linen",
    label: "Natural Linen",
    displayLabel: "Natural Linen",
    adjustment: 0,
    summaryLabel: "Included (+₹0)",
  },
  {
    id: "velvet",
    label: "Matte Velvet",
    displayLabel: "Matte Velvet",
    adjustment: 5000,
    summaryLabel: "+₹5,000",
  },
  {
    id: "leatherette",
    label: "Matte Vegan Leatherette",
    displayLabel: "Matte Vegan Leatherette",
    adjustment: 8000,
    summaryLabel: "+₹8,000",
  },
];

export const SEATING: SeatingOption[] = [
  {
    id: "two-seater",
    label: "2 Seater",
    adjustment: -7000,
    stageLabel: "2 Seater Standard",
  },
  {
    id: "three-seater",
    label: "3 Seater",
    adjustment: 0,
    stageLabel: "3 Seater Standard",
  },
  {
    id: "l-shape",
    label: "L Shape",
    adjustment: 18000,
    stageLabel: "L Shape Standard",
  },
];

export interface CustomiserConfig {
  modelId: ModelId;
  colourId: ColourId;
  fabricId: FabricId;
  seatingId: SeatingId;
}

export const DEFAULT_CONFIG: CustomiserConfig = {
  modelId: "luna",
  colourId: "beige",
  fabricId: "linen",
  seatingId: "three-seater",
};

export function getModel(id: ModelId): SofaModel {
  return SOFA_MODELS.find((model) => model.id === id) ?? SOFA_MODELS[0];
}

export function getFabric(id: FabricId): FabricOption {
  return FABRICS.find((fabric) => fabric.id === id) ?? FABRICS[0];
}

export function getSeating(id: SeatingId): SeatingOption {
  return SEATING.find((seating) => seating.id === id) ?? SEATING[0];
}

export function getColour(
  model: SofaModel,
  colourId: ColourId
): ColourOption | undefined {
  return model.colours.find((colour) => colour.id === colourId);
}

export function calculatePrice(config: CustomiserConfig): {
  base: number;
  fabricAdj: number;
  seatingAdj: number;
  total: number;
} {
  const model = getModel(config.modelId);
  const fabricAdj = getFabric(config.fabricId).adjustment;
  const seatingAdj = getSeating(config.seatingId).adjustment;
  return {
    base: model.basePrice,
    fabricAdj,
    seatingAdj,
    total: model.basePrice + fabricAdj + seatingAdj,
  };
}

// Formats rupees with Indian digit grouping, e.g. 42999 -> "₹42,999"
export function formatPrice(value: number): string {
  return `₹${value.toLocaleString("en-IN")}`;
}

// Formats a signed adjustment, e.g. 5000 -> "+₹5,000", 0 -> "+₹0"
export function formatAdjustment(value: number): string {
  return `+₹${value.toLocaleString("en-IN")}`;
}
