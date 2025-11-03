/******************************************************************************
 * NE PAS MODIFIER CE FICHIER
 *
 * Signatures des fonctions filtres a coder en assembleur
 *
 * Noter que extern "C" est utilise pour indiquer au compilateur de ne pas faire
 *de mangling. On peut donc appeler les fonctions ASM telles quelles sans se
 *soucier du mangling.
 *
 ******************************************************************************/

#pragma once

#include "image.h"

extern "C" bool isSameColor(Pixel a, Pixel b);
extern "C" void floodFill(Image *img, int x, int y, Pixel targetColor, Pixel newColor);
extern "C" void grayscale(Image *img);
extern "C" void invert(Image *img);
extern "C" void blur(Image *img, Image *imgCopy);

// Fonction entrante pour floodfill
void applyFloodFill(Image *img, int startX, int startY, Pixel newColor);