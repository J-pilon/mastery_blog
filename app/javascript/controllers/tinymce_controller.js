import { Controller } from "@hotwired/stimulus";
import { imagesUploadHandler } from "../utils/uploadHandler";

export default class extends Controller {
  connect() {
    tinymce.init({
      selector: "textarea#tinymce",
      height: 800,
      // plugins: [
      //   "image",
      //   "advlist autolink lists link image charmap print preview anchor",
      //   "searchreplace visualblocks code fullscreen",
      //   "insertdatetime media table paste code help wordcount",
      // ],
      toolbar:
        "file edit view insert format tools undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help | image",
      // skin: "oxide-dark",
      content_css: "/assets/tinymce",
      automatic_uploads: true,
      images_upload_handler: imagesUploadHandler,
    });

    document.addEventListener("imageUploadSuccess", this.onImageUploadSuccess);
  }

  onImageUploadSuccess(e) {
    const downloadUrl = e.detail.downloadUrl;
    const imageElement = document.querySelector("input#article_image_url");
    imageElement.value = downloadUrl;
    console.log(imageElement.value, " - Image URL set.");
  }

  disconnect() {
    // console.log("Tinymce controller disconnected.");
    document.removeEventListener(
      "imageUploadSuccess",
      this.onImageUploadSuccess
    );
    tinymce.activeEditor.destroy();
  }
}
