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
  shortLabel: string;
  hex: string;
}

export interface FabricOption {
  id: FabricId;
  label: string;
  displayLabel: string;
  description: string;
  priceLabel: string;
  adjustment: number;
  summaryLabel: string;
}

export interface SeatingOption {
  id: SeatingId;
  label: string;
  description: string;
  priceLabel: string;
  adjustment: number;
  stageLabel: string;
}

export interface SofaModel {
  id: ModelId;
  name: string;
  displayName: string;
  shortDesc: string;
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
    shortDesc: "Curved Boucle",
    basePrice: 42999,
    description:
      "Organic curved silhouette enveloped in soft, tactile boucle. Ideal for fluid, conversational open-plan spaces.",
    tag: "Curved Artistry",
    badges: ["Curved Silhouette", "High-Traffic Boucle", "Soft Density"],
    image: "/images/luna-sofa.png",
    colours: [
      { id: "beige", label: "Warm Beige", shortLabel: "Warm Beige", hex: "#E4D8C5" },
      { id: "charcoal", label: "Slate Charcoal", shortLabel: "Slate Charcoal", hex: "#4E5258" },
      { id: "olive", label: "Olive Moss", shortLabel: "Olive Moss", hex: "#556346" },
      { id: "midnight", label: "Midnight Blue", shortLabel: "Midnight Blue", hex: "#283B4B" },
    ],
  },
  {
    id: "urban",
    name: "Urban",
    displayName: "The Urban Mid-Century",
    shortDesc: "Walnut Velvet",
    basePrice: 54999,
    description:
      "Mid-century clean lines with solid walnut trim and firm ergonomic support.",
    tag: "Mid-Century Clean Lines",
    badges: ["Mid-Century Clean Lines", "Solid Walnut Trim", "Firm Ergonomic Support"],
    image: "/images/urban-sofa.png",
    colours: [
      { id: "beige", label: "Warm Beige", shortLabel: "Warm Beige", hex: "#E4D8C5" },
      { id: "charcoal", label: "Slate Charcoal", shortLabel: "Slate Charcoal", hex: "#4E5258" },
      { id: "olive", label: "Olive Moss", shortLabel: "Olive Moss", hex: "#556346" },
      { id: "midnight", label: "Midnight Blue", shortLabel: "Midnight Blue", hex: "#283B4B" },
    ],
  },
  {
    id: "cloud",
    name: "Cloud",
    displayName: "The Cloud Sectional",
    shortDesc: "Deep Lounge",
    basePrice: 64999,
    description:
      "Deep lounge sanctuary with cloud softness and an L-shape ready footprint.",
    tag: "Deep Sanctuary",
    badges: ["Deep Sanctuary", "Cloud Softness", "L-Shape Ready"],
    image: "/images/cloud-sofa.png",
    colours: [
      { id: "beige", label: "Warm Beige", shortLabel: "Warm Beige", hex: "#E4D8C5" },
      { id: "charcoal", label: "Slate Charcoal", shortLabel: "Slate Charcoal", hex: "#4E5258" },
      { id: "olive", label: "Olive Moss", shortLabel: "Olive Moss", hex: "#556346" },
      { id: "midnight", label: "Midnight Blue", shortLabel: "Midnight Blue", hex: "#283B4B" },
    ],
  },
];

export const FABRICS: FabricOption[] = [
  {
    id: "linen",
    label: "Natural Linen",
    displayLabel: "Natural Linen",
    description: "Breathable Belgian weave · 50k Martindale rubs",
    priceLabel: "Included",
    adjustment: 0,
    summaryLabel: "Included (+₹0)",
  },
  {
    id: "velvet",
    label: "Royal Velvet",
    displayLabel: "Royal Velvet",
    description: "Dense cotton pile · deep pigment saturation",
    priceLabel: "+₹5,000",
    adjustment: 5000,
    summaryLabel: "+₹5,000",
  },
  {
    id: "leatherette",
    label: "Vegan Leatherette",
    displayLabel: "Vegan Leatherette",
    description: "Spill-resistant matte finish · pet friendly",
    priceLabel: "+₹8,000",
    adjustment: 8000,
    summaryLabel: "+₹8,000",
  },
];

export const SEATING: SeatingOption[] = [
  {
    id: "two-seater",
    label: "2 Seater",
    description: "Compact Apartment",
    priceLabel: "−₹7,000",
    adjustment: -7000,
    stageLabel: "2 Seater Standard",
  },
  {
    id: "three-seater",
    label: "3 Seater",
    description: "Standard Living",
    priceLabel: "Included",
    adjustment: 0,
    stageLabel: "3 Seater Standard",
  },
  {
    id: "l-shape",
    label: "L Shape",
    description: "Sectional Lounge",
    priceLabel: "+₹18,000",
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
