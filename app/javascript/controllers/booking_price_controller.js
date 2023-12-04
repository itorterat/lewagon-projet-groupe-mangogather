import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "difficulty", "tip", "result", "formCategory", "formDifficulty", "formTip"]

  // connect() {
  //   this.calcul() // Effectue un calcul initial au chargement
  // }

  calcul() {
    const selectedServiceOption = this.formCategoryTarget.options[this.formCategoryTarget.selectedIndex];
    const categoryPrice = parseFloat(selectedServiceOption.getAttribute('data-price')) || 0;
    // const categoryPrice = this.formCategoryTarget.value
    const difficulty = this.formDifficultyTarget.value
    const tip = parseFloat(this.formTipTarget.value) || 0

    let difficultyCoefficient;
    switch (difficulty) {
      case 'easy':
        difficultyCoefficient = 0.75;
        break;
      case 'normal':
        difficultyCoefficient = 1;
        break;
      case 'hard':
        difficultyCoefficient = 1.5;
        break;
      // default:
      //   difficultyCoefficient = 1; // Valeur par défaut
    }
    const totalCost = (categoryPrice * difficultyCoefficient) + tip
    this.resultTarget.textContent = totalCost.toFixed(2)
  }
}
