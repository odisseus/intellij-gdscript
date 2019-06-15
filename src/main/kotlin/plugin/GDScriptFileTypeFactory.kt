package plugin

import com.intellij.openapi.fileTypes.FileTypeConsumer
import com.intellij.openapi.fileTypes.FileTypeFactory

class GDScriptFileTypeFactory : FileTypeFactory() {

    override fun createFileTypes(fileTypeConsumer: FileTypeConsumer) {
        fileTypeConsumer.consume(GDScriptFileType.INSTANCE, GDScriptFileType.FILE_EXTENSION)
    }

}
