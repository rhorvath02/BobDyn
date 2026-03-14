# BobLib Documentation

VitePress-based documentation site for BobLib vehicle dynamics framework.

## Tech Stack

- **VitePress** - Documentation-focused static site generator
- **KaTeX** - Fast math rendering
- **Vue 3** - VitePress framework
- **Markdown** - Content authoring

## Design

GNOME Nautilus-inspired dark theme with:

- System font stack
- 75ch max text width for readability
- Sticky navigation with Bob logo
- Clean, minimal interface

## Development

```bash
# Start dev server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

## Content Editing

All content is written in Markdown:

- **docs/index.md** - Home page content

### Math Equations

Use KaTeX syntax:

```markdown
Inline math: $a_y = \frac{v^2}{R}$

Display math:

$$
K = \frac{\partial \delta}{\partial a_y}
$$
```

### Custom Styling

Use HTML classes for special styling:

```markdown
<p class="section-intro">
Introductory text with muted color
</p>

<p class="closing-note">
Closing note with extra spacing
</p>
```
