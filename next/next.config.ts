import type { NextConfig } from "next";

const nextConfig: NextConfig = {
	turbopack: {
		// Needed because there is also a package-lock.json at the workspace root
		// (for Biome), which confuses Turbopack's auto-detection of the project root.
		root: __dirname,
	},
};

export default nextConfig;
