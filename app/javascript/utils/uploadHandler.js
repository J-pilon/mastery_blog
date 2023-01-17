export async function imagesUploadHandler(blobInfo, success, failure, progress) {
    // fetch presigned url for direct browser upload to S3
    const res = await fetch('/uploads/presigned_url', {method: 'GET'});
    const { presigned_url, download_url } = await res.json();
    
    // upload the file to S3 using presigned url
    try {
        const file = blobInfo.blob()
        await fetch(presigned_url, {method: 'PUT', body: file});
        success(download_url)
    } catch (err) {
        failure(`Image upload failed: ${err.message}`)
    }
    return download_url
}