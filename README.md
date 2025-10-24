# ACOC-Actin_cable_tortuosity
Scripts used in Actin Cable Organizing Center paper to quantify the length, shortest distance, and tortuosity of the actin cables in actin movies or fix cells.

## Overview
This FIJI macro measures the **tortuosity of actin cables** in *Saccharomyces cerevisiae* — quantifying how straight or curved each actin cable is.  
Tortuosity is defined as the ratio between the **total cable length** and its **Feret diameter** (the shortest distance between the cable endpoints).  
This provides a sensitive and quantitative measure of actin cable organization, curvature, and structural integrity.

---

## Prerequisites

### Required Software
- [FIJI (ImageJ)](https://fiji.sc/)
- [MorphoLibJ plugin](https://imagej.net/plugins/morpholibj)
- [Bio-Formats plugin](https://www.openmicroscopy.org/bio-formats/)

---

## Input Preparation

### Step 1 – Draw and Save Cable ROIs
Before running the macro, manually annotate actin cables in FIJI:

1. Open your **actin channel image** (e.g., MIP of actin cable stack).  
2. Use the **straight line tool** to draw a **reference line** near the **bud neck** or at the **start of the actin cable**.  
3. Use the **segmented line tool** (with *spline fit* enabled) to trace individual actin cables from their origin to tip.  
4. Add each cable as a new entry to the **ROI Manager**.  
5. When finished, save your annotated ROIs as:  
filename-tor-roiset.zip
6. Place the ROI set in a subfolder:
inputdir/ROI/
Example folder structure:
actin_tortuosity_experiment/
            ├── image1.ome.tiff
            ├── image2.ome.tiff
            └── ROI/
            ├── image1-tor-roiset.zip
            └── image2-tor-roiset.zip


---

## Running the Macro

1. Launch FIJI and open **`AOC-ActinCable_Tortuosity-v1.ijm`**.  
2. Specify:
   - **Input folder:** containing your raw images and ROI subfolder.  
   - **Output folder:** where you want to save results.  
3. The macro will automatically:
   - Load the raw actin images.  
   - Retrieve the corresponding ROI files (`filename-tor-roiset.zip`).  
   - Measure:
     - **Total cable length** (sum of segmented line path)  
     - **Feret diameter** (shortest straight-line distance between endpoints)  
     - **Tortuosity** (ratio of total length / Feret diameter)

---

## Output

| Output File | Description |
|--------------|-------------|
| `1-Tortuosity/file_name-Line00x-framex-FeretDiams.csv` | Quantitative Feret diameter results for individual cell |
| `1-Tortuosity/file_name-Line00x-framex-SkelGeodDiam.csv` | Quantitative cable length results for individual cell |
| `1-Tortuosity/file_name-FeretD-append.csv` | Quantitative results table including Feret diameter |
| `1-Tortuosity/file_name-GeoD-append.csv` | Quantitative results table including cable length |
| `1-Tortuosity/file_name-Tor-append.csv` | Quantitative results table including calculated tortuosity |
| `-Line001-frame1-mask.tif` | Annotated ROI mask showing cable ROIs for verification |

---

## Notes
- Use **spline fitting** for more accurate cable curvature tracing.  
- Tortuosity values close to **1.0** indicate nearly straight cables; higher values reflect greater curvature.  
- This macro uses **MorphoLibJ** for geometric and shape measurements.  
- The analysis is compatible with MIP or single-plane images of actin cables.

---

## Example Workflow (Hidden for Now)

<!--
### Example Workflow
1. **Example Input Image:** Raw actin cable field.  
2. **Example ROI Annotation:** Cables traced with segmented line (spline).  
3. **Example Tortuosity Output:** CSV table with cable length and curvature metrics.  
4. **Example QC Overlay:** Annotated cables overlaid on actin image.
-->

---

## Citation
If you use this macro in your research, please cite:  
> Yang, E.J.-N., Filpo, K., Boldogh, I., Swayne, T.C., and Pon, L.A. "Tying up loose ends: an actin cable organizing center contributes to actin cable polarity, function and quality control in budding yeast." submitted. [2025]
---

## License
Released under the [MIT License](LICENSE).

---

## Contact
For questions or customization requests, please contact:  
**[Emily Jie-Ning Yang]**  
Email: [emily.jiening.yang@gmail.com]
