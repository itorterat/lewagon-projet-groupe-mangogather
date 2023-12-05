import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "difficulty", "tip", "result", "formCategory", "formDifficulty", "formTip"]

  calcul() {
    const selectedServiceOption = this.formCategoryTarget.options[this.formCategoryTarget.selectedIndex];
    const categoryPrice = parseFloat(selectedServiceOption.getAttribute('data-price')) || 0;
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
    }
    const totalCost = (categoryPrice * difficultyCoefficient) + tip
    this.categoryTarget.textContent = categoryPrice
    this.difficultyTarget.textContent = difficultyCoefficient
    this.tipTarget.textContent = tip
    this.resultTarget.textContent = totalCost
  }
}
