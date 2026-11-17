# Figma Spec — Frame 7: Enquiry Form

Frame ID: 1001:2820 (approx)
Size: ~670 × ~980
Type: Contact/enquiry form section

## Description
Enquiry form section with form fields, configuration summary, and submit button.

## Verbatim Text Content
- Section heading (shared with customiser or separate)
- Field labels: "Full Name", "Phone Number (+91)", "Email Address", "Delivery City & Pincode", "Special Dimensions or Room Requirements (Optional)"
- Placeholders: "9876543210 (10 digits)", "ananya@architecturestudio.in", "e.g. Bangalore, 560038"
- Checkbox label: "Send a complimentary physical fabric swatch box (including the chosen fabric and 3 curated alternatives) to my delivery address at zero cost."
- Submit button: "Submit Bespoke Enquiry"
- Footer note: "Protected by end-to-end craft confidentiality. No marketing spam."

## Layout Structure
- Two-column grid: left column (enquiry form fields), right column (configuration summary)
- Form fields stacked vertically
- Configuration summary card on right
- Submit button at bottom
- Footer note below submit button

## Form Fields
1. Full Name — text input
2. Phone Number (+91) — text input with prefix
3. Email Address — text input
4. Delivery City & Pincode — text input
5. Special Dimensions or Room Requirements (Optional) — text area

## Colours
- Form input background: #fcf9f3 (off-white)
- Form input border: rgba(216,194,187,0.6)
- Submit button background: #8c4f3b (button brown)
- Submit button text: #ffffff
- Checkbox: checked/unchecked states

## Fonts
- Field labels: DM_Sans Medium 12px, uppercase, tracking 0.72px
- Field input: DM_Sans Regular 15px
- Submit button: DM_Sans SemiBold 14px
- Footer note: DM_Sans SemiBold 10px, uppercase, tracking 0.8px

## Shadows & Radii
- Form inputs: rounded pill (var(--radius-full) or 48px)
- Submit button: rounded pill (var(--radius-full))
- Focus states: border focus colour

## Assets
- None specific (uses generic form elements)

## Prototype Interactions
- Form validation on submit
- Success state after submit (no email sent — frontend only)
- Configuration summary updates live

## Responsive Notes
- Stacks fields vertically on mobile
- Summary card appears below form on mobile

## Frame Image Reference
- Frame image reference: images/07-enquiry-form.png (to be exported at 2x)