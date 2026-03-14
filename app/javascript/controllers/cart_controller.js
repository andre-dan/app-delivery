import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bar", "count", "total"]

  connect() {
    this.items = []
  }

  add(event) {
    const name  = event.params.name
    const price = parseFloat(event.params.price)
    this.items.push({ name, price })
    this.#refresh()

    // Visual feedback: pulse the + button
    const btn = event.currentTarget
    btn.classList.add("scale-125")
    setTimeout(() => btn.classList.remove("scale-125"), 150)
  }

  #refresh() {
    const count = this.items.length
    const total = this.items.reduce((sum, i) => sum + i.price, 0)

    this.countTarget.textContent = count
    this.totalTarget.textContent =
      "R$ " + total.toFixed(2).replace(".", ",")

    if (count > 0) {
      this.barTarget.classList.remove("translate-y-full", "opacity-0")
    } else {
      this.barTarget.classList.add("translate-y-full", "opacity-0")
    }
  }
}
