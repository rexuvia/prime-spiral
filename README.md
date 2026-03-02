# Prime Spiral Observatory

Explore the hidden constellations of prime numbers through two legendary spirals:

- **Ulam Spiral** – primes mapped on a Cartesian lattice forming diagonal streaks of arithmetic magic.
- **Sacks Spiral** – primes unfurling across a polar plane, tracing sunflower-like phyllotaxis.

## 🎮 Features
- **Dual Modes**: toggle between Ulam and Sacks projections instantly.
- **Fluid Navigation**: drag to pan, scroll or pinch to zoom with inertial motion.
- **Twin Prime Bonds**: highlight pairs separated by two and watch their amber threads weave through the cosmos.
- **Density Veil**: reveal prime-rich regions with an adaptive translucent heatmap.
- **Insight Annotations**: contextual callouts explain observed structures and prime lore.
- **Daily Palette**: color gradients shift every day based on the calendar, keeping the observatory fresh.
- **Accessibility**: colorblind-friendly palette toggle and screen reader live region for mode changes.

## 🛠️ Tech Stack
- Pure HTML5 Canvas + vanilla JavaScript (no build step).
- Web Worker driven incremental prime generation (lightweight sieve).
- Typed arrays + batched rendering for 100k+ primes at 60 FPS.
- Adaptive level-of-detail depending on zoom and viewport.

## 📂 Project Structure
```
prime-spiral/
├── index.html   # game source (self-contained HTML)
├── README.md    # documentation
└── .gitignore   # repo hygiene
```

## 🚀 Deployment
Live at **https://rexuvia.com/games/prime-spiral.html**

Source hosted at **https://github.com/rexuvia/prime-spiral**

## 📖 How to Play
1. Load the observatory and wait a moment for primes to stream in.
2. Drag to explore the lattice; use scroll or pinch gestures to zoom.
3. Use the control panel to toggle overlays and switch spiral projections.
4. Enable insights to hear the story behind each visual pattern.
5. Reset the view anytime to center yourself.

## 🧠 Learn More
- [Stanislaw Ulam's spiral (1963)](https://en.wikipedia.org/wiki/Ulam_spiral)
- [Sacks spiral (1994)](https://en.wikipedia.org/wiki/Sacks_spiral)
- [Twin primes conjecture](https://en.wikipedia.org/wiki/Twin_prime)

Enjoy tracing the galaxies made of numbers! ✨
