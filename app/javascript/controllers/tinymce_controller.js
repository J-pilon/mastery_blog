import { Controller } from "@hotwired/stimulus";
import { tinymceImageUploadHandler } from "../utils/uploadHandler";

export default class extends Controller {
  connect() {
    tinymce.init({
      selector: "textarea#tinymce",
      height: 400,
      // plugins: [
      //   "image",
      //   "advlist autolink lists link image charmap print preview anchor",
      //   "searchreplace visualblocks code fullscreen",
      //   "insertdatetime media table paste code help wordcount",
      // ],
      toolbar:
        "file edit view insert format tools undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help | image",
      content_css: "/assets/tinymce",
      automatic_uploads: true,
      images_upload_handler: tinymceImageUploadHandler,
    });

    document.addEventListener("imageUploadSuccess", this.onImageUploadSuccess);
  }

  onImageUploadSuccess(e) {
    const downloadUrl = e.detail.downloadUrl;
    const hiddenInput = document.querySelector("input#article_image_url");
    hiddenInput.value = downloadUrl;

    const imageElement = document.querySelector("img#article_image");
    imageElement.src = downloadUrl;
  }

  disconnect() {
    document.removeEventListener(
      "imageUploadSuccess",
      this.onImageUploadSuccess
    );
    tinymce.activeEditor.destroy();
  }
}
