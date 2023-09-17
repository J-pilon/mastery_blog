export function imagesUploadHandler(blob, _) {return new Promise(async (success, failure) => {
    const storageServiceUrl = '/uploads/storage_service'
    let file = blob

    if (!(file instanceof(File)) || !(file instanceof(Blob))) {
        file = blob.blob()
    }

    try {
        const responseFromStorageService = await fetch(storageServiceUrl, {method: 'GET'})
        if(!responseFromStorageService.ok) {
            throw `${responseFromStorageService.status} - ${responseFromStorageService.statusText}`
        }
        const { presigned_url, download_url } = await responseFromStorageService.json()

        const responseFromUpload = await fetch(presigned_url, {method: 'PUT', body: file})
        if(!responseFromUpload.ok) {
          throw `${responseFromUpload.status} - ${responseFromUpload.statusText}`
        }
        success(download_url)
    } catch (err) {
        failure({message: err, remove: true})
    }
})}