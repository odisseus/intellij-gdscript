package script.adaptors

import com.intellij.psi.tree.IElementType
import org.antlr.intellij.adaptor.parser.ANTLRParserAdaptor
import org.antlr.v4.runtime.Parser
import org.antlr.v4.runtime.tree.ParseTree
import script.ScriptLanguage
import script.grammar.ScriptParser

class ScriptParserAdaptor(parser: ScriptParser = ScriptParser(null)) : ANTLRParserAdaptor(ScriptLanguage, parser) {

    override fun parse(parser: Parser, root: IElementType): ParseTree {
        require(parser is ScriptParser)
        return parser.file()
    }

}