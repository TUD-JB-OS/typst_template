# python pdf2png.py document.pdf
# python pdf_to_png.py document.pdf --dpi 600

import argparse
from pathlib import Path
import pymupdf


def pdf_to_png(input_pdf, output_png=None, dpi=300):
    input_pdf = Path(input_pdf)

    if output_png is None:
        output_png = input_pdf.with_suffix(".png")

    with pymupdf.open(input_pdf) as doc:
        if len(doc) != 1:
            raise ValueError("PDF must contain exactly one page.")

        page = doc[0]
        pix = page.get_pixmap(dpi=dpi, alpha=False)
        pix.save(str(output_png))

    print(f"Saved: {output_png} ({dpi} DPI)")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Convert a single-page PDF to PNG."
    )
    parser.add_argument("input", help="Input PDF file")
    parser.add_argument(
        "-o", "--output",
        help="Output PNG file (default: same name as PDF)"
    )
    parser.add_argument(
        "--dpi",
        type=int,
        default=300,
        help="Output resolution (default: 300)"
    )

    args = parser.parse_args()

    if args.dpi <= 0:
        parser.error("--dpi must be a positive integer")

    pdf_to_png(args.input, args.output, args.dpi)
