export type ModelId = "luna" | "urban" | "cloud";
export type FabricId = "linen" | "velvet" | "leatherette";
export type SeatingId = "two-seater" | "three-seater" | "l-shape";

export interface ColourOption {
  id: string;
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

export interface CustomiserConfig {
  modelId: ModelId;
  colourId: string;
  fabricId: FabricId;
  seatingId: SeatingId;
}

export interface PriceBreakdown {
  total: number;
  base: number;
  fabricAdj: number;
  seatingAdj: number;
}

export const getModel = (id: ModelId): SofaModel => SOFA_MODELS.find((m) => m.id === id)!;

export const getFabric = (id: FabricId): FabricOption => FABRICS.find((f) => f.id === id)!;

export const getSeating = (id: SeatingId): SeatingOption => SEATING.find((s) => s.id === id)!;

export const getColour = (model: SofaModel, colourId: string): ColourOption => model.colours.find((c) => c.id === colourId)!;

export const calculatePrice = (config: CustomiserConfig): PriceBreakdown => {
  const model = SOFA_MODELS.find((m) => m.id === config.modelId)!;
  let price = model.basePrice;
  const fabric = FABRICS.find((f) => f.id === config.fabricId)!;
  const seating = SEATING.find((s) => s.id === config.seatingId)!;
  price += fabric.adjustment + seating.adjustment;
  return { total: price, base: model.basePrice, fabricAdj: fabric.adjustment, seatingAdj: seating.adjustment };
};

export const formatAdjustment = (adjustment: number): string => adjustment >= 0 ? `+₹${adjustment}` : `−₹${Math.abs(adjustment)}`;

export const formatPrice = (price: number): string => `\u20B9${price.toLocaleString("en-IN")}`;

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

export const DEFAULT_CONFIG: CustomiserConfig = {
  modelId: "luna",
  colourId: "beige",
  fabricId: "linen",
  seatingId: "three-seater",
};
