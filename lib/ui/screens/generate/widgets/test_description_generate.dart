import 'package:flutter/material.dart';
import 'package:ww_2/domain/enums/type_generate.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/generate/unit_decription_website.dart';

class TestDescriptionGenerate extends StatefulWidget {
  final TextEditingController controller;
  final TypeGenerate type;

  const TestDescriptionGenerate({
    super.key,
    required this.controller,
    required this.type,
  });

  @override
  State<TestDescriptionGenerate> createState() => TestDescriptionGenerateState();
}

class TestDescriptionGenerateState extends State<TestDescriptionGenerate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(bottom: widget.type == TypeGenerate.text ? 16 : 0),
          child: TextField(
            controller: widget.controller,
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            onChanged: (_) {
              if ([TypeGenerate.text, TypeGenerate.website].contains(widget.type)) setState(() {});
            },
            maxLines: null,
            minLines: 5,
            maxLength: widget.type == TypeGenerate.text ? 150 : null,
            decoration: InputDecoration(
              filled: false,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter ${widget.type == TypeGenerate.website ? 'website address' : 'text'}',
              counter: widget.type == TypeGenerate.text
                  ? Opacity(
                      opacity: .5,
                      child: Text(
                        '${widget.controller.text.length}/150',
                        style: AppText.text3,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        if (widget.type == TypeGenerate.website) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              _Scheme(
                scheme: 'http://',
                onTap: () {
                  final result = UnitDescriptionWebsite.http(widget.controller.text);
                  widget.controller.text = result;
                  setState(() {});
                },
                active: widget.controller.text.contains('http://'),
              ),
              const SizedBox(width: 11),
              _Scheme(
                scheme: 'https://',
                onTap: () {
                  final result = UnitDescriptionWebsite.https(widget.controller.text);
                  widget.controller.text = result;
                  setState(() {});
                },
                active: widget.controller.text.contains('https://'),
              ),
              const SizedBox(width: 11),
              _Scheme(
                scheme: 'www.',
                onTap: () {
                  final result = UnitDescriptionWebsite.www(widget.controller.text);
                  if (result == null) return;
                  widget.controller.text = result;
                  setState(() {});
                },
                active: widget.controller.text.contains('www.'),
              ),
              const SizedBox(width: 11),
              _Scheme(
                scheme: '.com',
                onTap: () {
                  final result = UnitDescriptionWebsite.com(widget.controller.text);
                  if (result == null) return;
                  widget.controller.text = result;
                  setState(() {});
                },
                active: widget.controller.text.contains('.com'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Scheme extends StatelessWidget {
  final String scheme;
  final bool active;
  final Function() onTap;

  const _Scheme({
    super.key,
    required this.onTap,
    required this.scheme,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white.withOpacity(.2),
          border: Border(
            bottom: BorderSide(
              color: active ? AppColors.primary : Colors.transparent,
            ),
          ),
        ),
        child: Opacity(
          opacity: active ? 1 : .5,
          child: Text(
            scheme,
            style: AppText.text3,
          ),
        ),
      ),
    );
  }
}
