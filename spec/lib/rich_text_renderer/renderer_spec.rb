require 'spec_helper'

full_document = {
    "content" => [
        {
            "data" => {},
            "content" => [
                {
                    "marks" => [],
                    "value" => "Some heading",
                    "nodeType" => "text",
                    "nodeClass" => "text",
                }
            ],
            "nodeType" => "heading-1",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {
                "target" => {
                    "sys" => {
                        "id" => "49rofLvvxCOiIMIi6mk8ai",
                        "type" => "Link",
                        "linkType" => "Entry",
                    }
                }
            },
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "embedded-entry-block",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {
                    "marks" => [],
                    "value" => "Some subheading",
                    "nodeType" => "text",
                    "nodeClass" => "text",
                }
            ],
            "nodeType" => "heading-2",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {
                    "marks" => [{"data" => {}, "type" => "bold", "object" => "mark"}],
                    "value" => "Some bold",
                    "nodeType" => "text",
                    "nodeClass" => "text",
                }
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {
                    "marks" => [{"data" => {}, "type" => "italic", "object" => "mark"}],
                    "value" => "Some italics",
                    "nodeType" => "text",
                    "nodeClass" => "text",
                }
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {
                    "marks" => [{"data" => {}, "type" => "underline", "object" => "mark"}],
                    "value" => "Some underline",
                    "nodeType" => "text",
                    "nodeClass" => "text",
                }
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {
                "target" => {
                    "sys" => {
                        "id" => "5ZF9Q4K6iWSYIU2OUs0UaQ",
                        "type" => "Link",
                        "linkType" => "Entry",
                    }
                }
            },
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "embedded-entry-block",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {
                    "marks" => [],
                    "value" => "Some raw content",
                    "nodeType" => "text",
                    "nodeClass" => "text",
                }
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {
                    "marks" => [],
                    "value" => "An unpublished embed:",
                    "nodeType" => "text",
                    "nodeClass" => "text",
                }
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
        {
            "data" => {
                "target" => {
                    "sys" => {
                        "id" => "q2hGXkd5tICym64AcgeKK",
                        "type" => "Link",
                        "linkType" => "Entry",
                    }
                }
            },
            "content" => [
                {"marks" => [], "value" => "", "nodeType" => "text", "nodeClass" => "text"}
            ],
            "nodeType" => "embedded-entry-block",
            "nodeClass" => "block",
        },
        {
            "data" => {},
            "content" => [
                {
                    "marks" => [],
                    "value" => "Some more content",
                    "nodeType" => "text",
                    "nodeClass" => "text",
                }
            ],
            "nodeType" => "paragraph",
            "nodeClass" => "block",
        },
    ],
    "nodeType" => "document",
    "nodeClass" => "document",
}

describe RichTextRenderer::Renderer do
  subject { described_class.new }

  describe '#render' do
    it 'by default renders html' do
      expect(subject.render(full_document)).to eq [
        "<h1>Some heading</h1>",
        "<p></p>",
        '<div>{"sys"=>{"id"=>"49rofLvvxCOiIMIi6mk8ai", "type"=>"Link", "linkType"=>"Entry"}}</div>',
        "<h2>Some subheading</h2>",
        "<p><b>Some bold</b></p>",
        "<p><i>Some italics</i></p>",
        "<p><u>Some underline</u></p>",
        "<p></p>",
        "<p></p>",
        '<div>{"sys"=>{"id"=>"5ZF9Q4K6iWSYIU2OUs0UaQ", "type"=>"Link", "linkType"=>"Entry"}}</div>',
        "<p></p>",
        "<p>Some raw content</p>",
        "<p></p>",
        "<p>An unpublished embed:</p>",
        "<p></p>",
        '<div>{"sys"=>{"id"=>"q2hGXkd5tICym64AcgeKK", "type"=>"Link", "linkType"=>"Entry"}}</div>',
        "<p>Some more content</p>",
      ].join("\n")
    end
  end

  describe 'with all renderers overridden' do
    subject do
      described_class.new(
        'heading-1' => HeadingOneMarkdownRenderer,
        'heading-2' => HeadingTwoMarkdownRenderer,
        'paragraph' => ParagraphMarkdownRenderer,
        'embedded-entry-block' => EntryBlockMarkdownRenderer,
        'bold' => BoldMarkdownRenderer,
        'italic' => ItalicMarkdownRenderer,
        'underline' => UnderlineMarkdownRenderer
      )
    end

    it 'renders with the overridden renderers' do
      expect(subject.render(full_document)).to eq [
        "# Some heading",
        "",
        "",
        "",
        "",
        "```",
        '{"sys"=>{"id"=>"49rofLvvxCOiIMIi6mk8ai", "type"=>"Link", "linkType"=>"Entry"}}',
        "```",
        "",
        "## Some subheading",
        "",
        "**Some bold**",
        "",
        "",
        "*Some italics*",
        "",
        "",
        "__Some underline__",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "```",
        '{"sys"=>{"id"=>"5ZF9Q4K6iWSYIU2OUs0UaQ", "type"=>"Link", "linkType"=>"Entry"}}',
        "```",
        "",
        "",
        "",
        "",
        "",
        "Some raw content",
        "",
        "",
        "",
        "",
        "",
        "An unpublished embed:",
        "",
        "",
        "",
        "",
        "",
        "```",
        '{"sys"=>{"id"=>"q2hGXkd5tICym64AcgeKK", "type"=>"Link", "linkType"=>"Entry"}}',
        "```",
        "",
        "",
        "Some more content",
        ""
      ].join("\n")
    end
  end
end
