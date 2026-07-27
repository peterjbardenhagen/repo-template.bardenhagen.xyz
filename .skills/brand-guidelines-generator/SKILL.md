# Brand Guidelines Generator

This skill helps AI agents create comprehensive brand guidelines from websites, brand collateral, or basic input. It extracts visual identity elements and creates ready-to-use brand guidelines.

## When to Use

Use this skill when:
- Creating brand guidelines for a new project
- Need to extract branding from an existing website
- Want to generate consistent visual identity for AI design work
- Setting up a repository for future AI agent design tasks

## How It Works

The generator can:
1. Extract branding from a website URL using web scraping
2. Process uploaded brand collateral (logos, style guides)
3. Generate comprehensive brand guidelines based on input
4. Create stock photography folders with relevant imagery
5. Generate logo concepts if none are provided
6. Output everything to a standardized location in the repo

## Usage

Activate this skill and then ask for the website URL or brand assets to process.

The generator will:
- Ask for input (website URL, file path, or manual brand details)
- Fetch/process the input to extract brand elements
- Generate brand guidelines document
- Create asset folders (logos, imagery, etc.)
- Save everything to `docs/brand-guidelines/` for AI agent access by default

## Integration

This skill works with:
- Web scraping tools (Firecrawl) to extract from websites
- Image processing for logo handling
- Stock photo APIs for imagery collection
- Template system for consistent guideline generation

AI agents can then use these generated guidelines when designing websites, marketing materials, or UI components.

## Example Workflow

1. User activates skill: "Generate brand guidelines for my website"
2. System asks: "Please provide your website URL or brand collateral path"
3. User provides: "https://example.com"
4. System extracts branding from the website
5. System generates brand guidelines document
6. System creates stock photo folder with relevant imagery
7. System saves everything to `docs/brand-guidelines/example-com/`
8. AI agents can now reference these guidelines for design work