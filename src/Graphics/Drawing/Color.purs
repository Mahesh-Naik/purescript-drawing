-- | This module defines preset colors, and functions for creating colors.

module Graphics.Drawing.Color
  ( Color()

  , colorString

  , rgb
  , rgba
  , hsl

  , lighten
  , darken

  , white
  , silver
  , gray
  , black
  , red
  , maroon
  , yellow
  , olive
  , lime
  , green
  , aqua
  , teal
  , blue
  , navy
  , fuchsia
  , purple
  ) where

import Prelude

import Math
import qualified Data.Int as I

-- | Colors.
data Color = Color Number Number Number Number

instance eqColor :: Eq Color where
  eq (Color r g b a) (Color r' g' b' a') = r == r'
                                        && g == g'
                                        && b == b'
                                        && a == a'

-- | Create a `Color` from RGB values between 0.0 and 255.0.
rgb :: Number -> Number -> Number -> Color
rgb r g b = Color r g b 1.0

-- | Create a `Color` from RGBA values between 0.0 and 255.0 (rgb), 0.0 and 1.0 (a)
rgba :: Number -> Number -> Number -> Number -> Color
rgba = Color

-- | Create a `Color` from hue (0.0-360.0), saturation (0.0-1) and lightness (0.0-1) values.
hsl :: Number -> Number -> Number -> Color
hsl h s l = rgb (255.0 * (rgb1.r + m))
                (255.0 * (rgb1.g + m))
                (255.0 * (rgb1.b + m))
  where
  h'  = h / 60.0
  chr = (1.0 - abs (2.0 * l - 1.0)) * s
  m   = l - chr / 2.0
  x   = chr * (1.0 - abs (h' % 2.0 - 1.0))
  rgb1 |              h' < 1.0 = { r: chr, g: x  , b: 0.0 }
       | 1.0 <= h' && h' < 2.0 = { r: x  , g: chr, b: 0.0 }
       | 2.0 <= h' && h' < 3.0 = { r: 0.0, g: chr, b: x   }
       | 3.0 <= h' && h' < 4.0 = { r: 0.0, g: x  , b: chr }
       | 4.0 <= h' && h' < 5.0 = { r: x  , g: 0.0, b: chr }
       | otherwise             = { r: chr, g: 0.0, b: x   }

-- | Lighten a color by the specified amount between 0 and 1.
lighten :: Number -> Color -> Color
lighten l (Color r g b a) = Color (interp r) (interp g) (interp b) a
  where
  interp c = 255.0 * l + c * (1.0 - l)

-- | Darken a color by the specified amount between 0 and 1.
darken :: Number -> Color -> Color
darken d (Color r g b a) = Color (interp r) (interp g) (interp b) a
  where
  interp c = c * (1.0 - d)

-- | Render a color as a HTML color string.
colorString :: Color -> String
colorString (Color r g b a) = "rgba(" <> show (I.floor r) <> "," <> show (I.floor g) <> "," <> show (I.floor b) <> "," <> show a <> ")"

white :: Color
white = rgb 255.0 255.0 255.0

silver :: Color
silver = rgb 192.0 192.0 192.0

gray :: Color
gray = rgb 128.0 128.0 128.0

black :: Color
black = rgb 0.0 0.0 0.0

red :: Color
red = rgb 255.0 0.0 0.0

maroon :: Color
maroon = rgb 128.0 0.0 0.0

yellow :: Color
yellow = rgb 255.0 255.0 0.0

olive :: Color
olive = rgb 128.0 128.0 0.0

lime :: Color
lime = rgb 0.0 255.0 0.0

green :: Color
green = rgb 0.0 128.0 0.0

aqua :: Color
aqua = rgb 0.0 255.0 255.0

teal :: Color
teal = rgb 0.0 128.0 128.0

blue :: Color
blue = rgb 0.0 0.0 255.0

navy :: Color
navy = rgb 0.0 0.0 128.0

fuchsia :: Color
fuchsia = rgb 255.0 0.0 255.0

purple :: Color
purple = rgb 128.0 0.0 128.0
