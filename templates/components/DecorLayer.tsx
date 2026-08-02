/**
 * DecorLayer — Safe wrapper for ambient decorative elements
 *
 * Ensures decorative blobs, gradients, and visual effects don't cause
 * horizontal scroll on mobile devices. Uses overflow-hidden clipping.
 *
 * Reference: DR Standard 01 — Responsive & Mobile Width
 * https://digitalresponse.com.au/standards
 *
 * Usage:
 * import { DecorLayer, Blob } from '@/components/DecorLayer';
 *
 * <DecorLayer>
 *   <Blob size={600} blur={120} className="top-0 left-1/4" color="bg-blue-500/10" />
 * </DecorLayer>
 */

export function DecorLayer({ children }: { children: React.ReactNode }) {
  return (
    <div className="absolute inset-0 overflow-hidden pointer-events-none" aria-hidden="true">
      {children}
    </div>
  );
}

interface BlobProps {
  /**
   * Base size of the blob in pixels. Scales responsively on mobile to min(size, 120vw).
   * @default 400
   */
  size?: number;

  /**
   * CSS blur filter value in pixels.
   * @default 100
   */
  blur?: number;

  /**
   * Additional Tailwind classes for positioning (e.g., "top-0 left-1/4")
   */
  className?: string;

  /**
   * Tailwind color class (e.g., "bg-blue-500/10", "bg-emerald-500/20")
   * @default "bg-blue-500/10"
   */
  color?: string;
}

/**
 * Responsive blob element for ambient decoration.
 *
 * Emits width/height: min(size, 120vw) so it scales on mobile instead of
 * causing horizontal overflow.
 */
export function Blob({
  size = 400,
  blur = 100,
  className = '',
  color = 'bg-blue-500/10',
}: BlobProps) {
  return (
    <div
      className={`absolute rounded-full ${color} ${className}`}
      style={{
        width: `min(${size}px, 120vw)`,
        height: `min(${size}px, 120vw)`,
        filter: `blur(${blur}px)`,
        WebkitFilter: `blur(${blur}px)`,
      }}
      aria-hidden="true"
    />
  );
}
