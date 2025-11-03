/******************************************************************************
 * INF1600 - A25 - TP3 : Filtres BMP (ASM)
 *
 * No. d'équipe : GrX_Y
 * Auteurs et matricules :
 * Date :
 *
 * Description :
 *   Programme qui applique divers filtres sur des images BMP.
 *
 * Sources pour les images :
 *
 ******************************************************************************/

#include "filters.h"
#include "image.h"

int main() {
  // Ouvrir les images
  // TODO: 1- Placer vos images .BMP dans le dossier /bmp (SVP mettre les
  // sources en entete)
  // TODO: 2- Mettre a jour le chemin vers les images
  Image invertImg("bmp/image.bmp");
  Image grayscaleImg("bmp/image.bmp");
  Image blurImg("bmp/image.bmp");
  Image copyImg(blurImg); // ne pas modifier, doit etre une copie de blurImg
  Image floodFillImg("bmp/image.bmp");

  // TODO: Choisir une couleur
  Pixel floodColor{255, 0, 0};

  // Appliquer les filtres
  invert(&invertImg);
  grayscale(&grayscaleImg);
  blur(&blurImg, &copyImg);
  applyFloodFill(&floodFillImg, 320, 200, floodColor);

  // Sauvegarder les images
  // Elles apparaitront dans le dossier racine (chemin par defaut)
  invertImg.saveImage("invert.bmp");
  grayscaleImg.saveImage("grayscale.bmp");
  blurImg.saveImage("blur.bmp");
  floodFillImg.saveImage("floodfill.bmp");
}
