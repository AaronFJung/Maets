import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";

/**
 * Supabase client for use in Server Components, Server Actions, and Route Handlers.
 *
 * Wires Supabase's auth/session cookies to Next.js's request cookies. In Next.js
 * 15+ `cookies()` is async, so this helper is async too — always `await` it:
 *
 *   import { createClient } from "@/lib/supabase/server";
 *   const supabase = await createClient();
 */
export async function createClient() {
	const cookieStore = await cookies();

	return createServerClient(
		process.env.NEXT_PUBLIC_SUPABASE_URL!,
		process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
		{
			cookies: {
				getAll() {
					return cookieStore.getAll();
				},
				setAll(cookiesToSet) {
					try {
						cookiesToSet.forEach(({ name, value, options }) => {
							cookieStore.set(name, value, options);
						});
					} catch {
						// Called from a Server Component, where cookies are read-only.
						// Safe to ignore once a session-refreshing middleware is added.
					}
				},
			},
		},
	);
}
