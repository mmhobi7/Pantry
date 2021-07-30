import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/email_model.dart';
import 'model/email_store.dart';

const _avatarsLocation = 'reply/avatars';

class ComposePageState extends StatefulWidget {
  const ComposePageState({Key key}) : super(key: key);

  @override
  ComposePage createState() => ComposePage();
}

class ComposePage extends State<ComposePageState> {
  String _location = "Not set yet";

  @override
  Widget build(BuildContext context) {
    var _senderEmail = 'flutterfan@gmail.com';
    var _subject = '';
    var _recipient = 'Recipient';
    var _recipientAvatar = 'reply/avatars/avatar_0.jpg';

    final emailStore = Provider.of<EmailStore>(context);

    if (emailStore.selectedEmailId >= 0) {
      final currentEmail = emailStore.currentEmail;
      _subject = currentEmail.subject;
      _recipient = currentEmail.sender;
      _recipientAvatar = currentEmail.avatar;
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: double.infinity,
          child: Material(
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SubjectRow(subject: _subject, loc: _location),
                  const _SectionDivider(),
                  __AutocompleteLocation(
                      callback: (val) => setState(() => _location = val)),
                  const _SectionDivider(),
                  _RecipientsRow(
                    recipients: _recipient,
                    avatar: _recipientAvatar,
                  ),
                  const _SectionDivider(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      minLines: 6,
                      maxLines: 20,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'New Message...',
                      ),
                      autofocus: false,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubjectRow extends StatefulWidget {
  //TODO this
  const _SubjectRow({@required this.subject, this.loc})
      : assert(subject != null);

  final String subject;
  final String loc;

  @override
  _SubjectRowState createState() => _SubjectRowState();
}

class _SubjectRowState extends State<_SubjectRow> {
  TextEditingController _subjectController;

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController(text: widget.subject);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final emailStore = Provider.of<EmailStore>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            key: const ValueKey('ReplyExit'),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _subjectController,
              maxLines: 1,
              autofocus: false,
              style: theme.textTheme.headline6,
              decoration: InputDecoration.collapsed(
                hintText: 'Item',
                hintStyle: theme.textTheme.headline6.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              emailStore.addItem(InboxEmail(
                id: 0,
                sender: widget.loc,
                time: DateTime.now(),
                subject: _subjectController.text,
                message: 'Cucumber Mjjjask Facial has shipped.\n\n'
                    'Keep an eye out for a package to arrive between this Thursday and next Tuesday. If for any reason you don\'t receive your package before the end of next week, please reach out to us for details on your shipment.\n\n'
                    'As always, thank you for shopping with us and we hope you love our specially formulated Cucumber Mask!',
                avatar: '$_avatarsLocation/avatar_express.png',
                recipients: 'Jeff',
                containsPictures: false,
                type: ["inbox"],
              ));
              Navigator.of(context).pop();
            },
            icon: IconButton(
              icon: ImageIcon(
                const AssetImage(
                  'reply/icons/twotone_send.png',
                  package: 'flutter_gallery_assets',
                ),
                color: colorScheme.onSurface,
              ),
              onPressed: () {
                emailStore.addItem(InboxEmail(
                  id: 0,
                  sender: widget.loc,
                  time: DateTime.now(),
                  subject: _subjectController.text,
                  message: 'Cucumber Mjjjask Facial has shipped.\n\n'
                      'Keep an eye out for a package to arrive between this Thursday and next Tuesday. If for any reason you don\'t receive your package before the end of next week, please reach out to us for details on your shipment.\n\n'
                      'As always, thank you for shopping with us and we hope you love our specially formulated Cucumber Mask!',
                  avatar: '$_avatarsLocation/avatar_express.png',
                  recipients: 'Jeff',
                  containsPictures: false,
                  type: ["inbox"],
                ));
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

typedef void StringCallback(String val);

class __AutocompleteLocation extends StatelessWidget {
  const __AutocompleteLocation({Key key, this.callback}) : super(key: key);
  final StringCallback callback;

  void _printLatestValue(TextEditingController textEditingController) {
    callback(textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    final emailStore = Provider.of<EmailStore>(context);
    final _kOptions = emailStore.getLocs();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        top: 16,
        right: 12,
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Autocomplete<String>(
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              textEditingController
                  .addListener(() => _printLatestValue(textEditingController));
              return TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Location',
                ),
                style: Theme.of(context).textTheme.bodyText2,
                focusNode: focusNode,
                onFieldSubmitted: (String value) {
                  onFieldSubmitted();
                },
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return _kOptions.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              callback(selection);
            },
          ))
        ],
      ),
    );
  }
}

class _RecipientsRow extends StatelessWidget {
  const _RecipientsRow({
    @required this.recipients,
    @required this.avatar,
  })  : assert(recipients != null),
        assert(avatar != null);

  final String recipients;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Wrap(
              children: [
                Chip(
                  backgroundColor:
                      Theme.of(context).chipTheme.secondarySelectedColor,
                  padding: EdgeInsets.zero,
                  avatar: CircleAvatar(
                    backgroundImage: AssetImage(
                      avatar,
                      package: 'flutter_gallery_assets',
                    ),
                  ),
                  label: Text(
                    recipients,
                  ),
                ),
              ],
            ),
          ),
          InkResponse(
            customBorder: const CircleBorder(),
            onTap: () {},
            radius: 24,
            child: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.1,
      indent: 10,
      endIndent: 10,
    );
  }
}
