import { Controller } from "stimulus";
import { vanillaSelectBox } from '../external/vanillaSelectBox'

export default class extends Controller {
  static targets = ["item"];
  static values = { selectedIndices: Array };

  connect() {
    let selectBox = new vanillaSelectBox("#list_category_ids",{"maxHeight":200,search:true});
  }

  onClick(event) {
    // console.log(this.element)
    // let controllerElem = this.element
    //   let elem = event.target
    //   let categoryID = elem.value
    //   elem.selected = true;
    // //   this.selectedIndicesValue.push(categoryID)
    //     if (!this.selectedIndicesValue.includes(Number(categoryID))) {
    //         this.selectedIndicesValue = this.selectedIndicesValue.concat([Number(categoryID)])
    //     }
    //   console.log(elem)
    //   let e = this.element
    //   let results = e.options[e.selectedIndices].value
    //   console.log(results)
    // this.itemTargets.each(item => {
    //     if (item.selected)
    // })
    // console.log(controllerElem.selectedOptions)
    // controllerElem.selectedOptions.push(categoryID);
  }

  selectedIndicesValueChanged(value, prevValue) {
    // console.log(this.element);
    // for (let option of this.element.options) {
    //   //   console.log(option)
    //   //   console.log(option.value)
    //   if (this.selectedIndicesValue.includes(Number(option.value))) {
    //     console.log("selected");
    //     option.selected = true;
    //     option.classList.toggle("select");
    //   }
    // }
  }
}
