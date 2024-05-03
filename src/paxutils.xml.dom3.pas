unit paxutils.xml.dom3;

{$mode ObjFPC}{$H+}
{$Codepage UTF8}
interface

uses
  Classes, SysUtils;

const
  // NodeType
  ELEMENT_NODE = 1;
  ATTRIBUTE_NODE = 2;
  TEXT_NODE = 3;
  CDATA_SECTION_NODE = 4;
  ENTITY_REFERENCE_NODE = 5;
  ENTITY_NODE = 6;
  PROCESSING_INSTRUCTION_NODE = 7;
  COMMENT_NODE = 8;
  DOCUMENT_NODE = 9;
  DOCUMENT_TYPE_NODE = 10;
  DOCUMENT_FRAGMENT_NODE = 11;
  NOTATION_NODE = 12;

  // UserDataHandle
  NODE_CLONED = 1;
  NODE_IMPORTED = 2;
  NODE_DELETED = 3;
  NODE_RENAMED = 4;
  NODE_ADOPTED = 5;


  // DocumentPosition
  DOCUMENT_POSITION_DISCONNECTED = $01;
  DOCUMENT_POSITION_PRECEDING = $02;
  DOCUMENT_POSITION_FOLLOWING = $04;
  DOCUMENT_POSITION_CONTAINS = $08;
  DOCUMENT_POSITION_CONTAINED_BY = $10;
  DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = $20;


type
  EDOMException = class(Exception)
  const
    INDEX_SIZE_ERR = 1;
    String_SIZE_ERR = 2;
    HIERARCHY_REQUEST_ERR = 3;
    WRONG_DOCUMENT_ERR = 4;
    INVALID_CHARACTER_ERR = 5;
    NO_DATA_ALLOWED_ERR = 6;
    NO_MODIFICATION_ALLOWED_ERR = 7;
    NOT_FOUND_ERR = 8;
    NOT_SUPPORTED_ERR = 9;
    INUSE_ATTRIBUTE_ERR = 10;
    INVALID_STATE_ERR = 11;
    SYNTAX_ERR = 12;
    INVALID_MODIFICATION_ERR = 13;
    NAMESPACE_ERR = 14;
    INVALID_ACCESS_ERR = 15;

  end;

  DOMTimeStamp = uint64;

  ICharacterData = interface;
  IDocument = interface;
  INamedNodeMap = interface;
  INode = interface;
  INodeList = interface;
  INotation = interface;
  IUserDataHandler = interface;
  IDocumentType = interface;
  IDOMImplementation = interface;


  IDOMImplementation = interface
    ['{F6359A01-64DC-45DA-83B6-E20851CA3830}']
    function hasFeature(const feature, version: string): boolean;
    function createDocumentType(const qualifiedName, publicId, systemId: string): IDocumentType;//raises(DOMException);
    function createDocument(const namespaceURI, qualifiedName, doctype: IDocumentType): IDocument;           //raises(DOMException);
  end;

  { IDocumentType }

  IDocumentType = interface
    ['{CB86E729-D0E8-4A34-9B31-71217912BED3}']
    function getEntities: INamedNodeMap;
    function getInternalSubset: string;
    function getName: string;
    function getNotations: INamedNodeMap;
    function getPublicId: string;
    function getSystemId: string;
    property Name: string read getName;
    property entities: INamedNodeMap read getEntities;
    property notations: INamedNodeMap read getNotations;
    property publicId: string read getPublicId;
    property systemId: string read getSystemId;
    // Introduced in DOM Level 2:
    property internalSubset: string read getInternalSubset;
  end;

  INode = interface
    ['{CBEB308D-06B0-4741-AF1E-969BCD4955AD}']
    function getNodeName(): string;
    function getNodeValue(): string;
    procedure setNodeValue(nodeValue: string);

    function getNodeType(): int16;
    function getParentNode(): INode;
    function getChildNodes(): INodeList;
    function GetFirstChild(): INode;
    function getLastChild(): INode;
    function getPreviousSibling(): INode;
    function getNextSibling(): INode;
    function getAttributes(): INamedNodeMap;
    function getOwnerDocument(): IDocument;
    function insertBefore(newChild, refChild: INode): INode;

    function replaceChild(newChild, oldChild: INode): INode;
    function removeChild(oldChild: INode): INode;
    function appendChild(newChild: INode): INode;
    function hasChildNodes(): boolean;
    function cloneNode(deep: boolean): INode;
    procedure normalize();
    function isSupported(feature, version: string): boolean;
    function getNamespaceURI(): string;
    function getPrefix(): string;
    procedure setPrefix(prefix: string);
    function getLocalName(): string;
    function hasAttributes(): boolean;
    function getBaseURI(): string;
    function compareDocumentPosition(other: INode): int16;
    function getTextContent(): string;
    procedure setTextContent(textContent: string);
    function isSameNode(other: INode): boolean;
    function lookupPrefix(namespaceURI: string): string;
    function isDefaultNamespace(namespaceURI: string): boolean;
    function lookupNamespaceURI(prefix: string): string;
    function isEqualNode(arg: INode): boolean;
    function getFeature(feature: string; version: string): TObject;
    function setUserData(key: string; Data: Pointer; handler: IUserDataHandler): Pointer;
    function getUserData(key: string): Pointer;
  end;

  INodeList = interface
    ['{9F4D5662-2CD0-4C35-BCC9-0F9E20FF72B1}']
    function item(index: int32): INode;
    function getLength(): int32;
  end;

  INamedNodeMap = interface
    ['{9A2F131C-5C8A-4C0A-B560-DC4A5091A41C}']
    function getNamedItem(Name: string): INode;
    function setNamedItem(arg: INode): INode;
    function removeNamedItem(Name: string): INode;
    function item(index: int32): INode;
    function getLength(): int32;
    function getNamedItemNS(namespaceURI, localName: string): INode;
    function setNamedItemNS(arg: INode): INode;
    function removeNamedItemNS(namespaceURI, localName: string): INode;
  end;

  IDocument = interface
    ['{9E948AE6-1338-4EC1-89FB-98B0E0791A9F}']
  end;

  IUserDataHandler = interface
    ['{2A915E68-B900-4D8A-B6BB-E692DA4846C8}']
    procedure handle(operation: int16; key: string; Data: Pointer; src, dst: INode);
  end;

  INotation = interface(INode)
    ['{111D8F3D-6D2D-4976-8FA1-0ADE64397DD7}']
    function getPublicId(): string;
    function getSystemId(): string;
  end;

  ICharacterData = interface(INode)
    ['{9BC7C372-400B-49C9-811A-0BED161BBAF2}']
    function getData(): string;
    procedure setData(Data: string);
    function getLength(): int32;
    function substringData(offset, Count: int32): string;
    procedure appendData(arg: string);
    procedure insertData(offset: int32; arg: string);
    procedure deleteData(offset, Count: int32);
    procedure replaceData(offset, Count: int32; arg: string);
  end;

  IComment = interface(ICharacterData)
    ['{D9EA555E-66B7-486D-BDE3-96163E6D3161}']
  end;

implementation

end.
