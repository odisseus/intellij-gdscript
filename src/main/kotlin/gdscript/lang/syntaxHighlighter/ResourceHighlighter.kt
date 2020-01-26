package gdscript.lang.syntaxHighlighter

import com.intellij.openapi.editor.colors.TextAttributesKey
import com.intellij.openapi.fileTypes.SyntaxHighlighterBase
import com.intellij.psi.tree.IElementType
import gdscript.ResourceLexer
import gdscript.lang.ResourceLanguage
import gdscript.lang.ResourceTokenSet
import org.antlr.intellij.adaptor.lexer.ANTLRLexerAdaptor
import gdscript.colorSettingsPage.ColorTextAttributeKey as Color

class ResourceHighlighter : SyntaxHighlighterBase() {

    override fun getTokenHighlights(element: IElementType): Array<TextAttributesKey> =
        pack(matchingToColor(element)?.key)

    override fun getHighlightingLexer() =
        ANTLRLexerAdaptor(ResourceLanguage, ResourceLexer(null))

    private fun matchingToColor(element: IElementType) = when (element) {
        in ResourceTokenSet.KEYWORDS -> Color.KEYWORD
        in ResourceTokenSet.IDENTIFIERS -> Color.INSTANCE_FIELD
        in ResourceTokenSet.NUMBERS -> Color.NUMBER
        in ResourceTokenSet.STRINGS -> Color.STRING
        in ResourceTokenSet.RESOURCES -> Color.RESOURCE
        in ResourceTokenSet.LINE_COMMENTS -> Color.LINE_COMMENT
        else -> null
    }

}
